//
//  CharacterUseCaseTests.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 05/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import NIO
import XCTest

final class CharacterUseCaseTests: XCTestCase {

    private var eventLoop: EventLoop!
    private var sut: CharacterUseCase!
    private var table: String!

    override func setUpWithError() throws {
        _ = LocalServer(enabled: true)
        MockDB.removeAll()
        eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1).next()
        table = String.tableName(for: "TEST")
        let items = CharacterFactory.makeDatabaseItems()
        sut = CharacterUseCaseFactoryMock(items: items).makeUseCase()
    }

    override func tearDownWithError() throws {
        eventLoop = nil
        sut = nil
        table = nil
    }
    
    func test_whenAvailableFields_isEqualToGivenFields() {
        // Given
        let fields = Set(["series", "comics"])

        // When

        // Then
        XCTAssertEqual(sut.availableFields.sorted(), fields.sorted())
    }
    
    func testGetItem_whenFieldIsInvalid_throwInvalidFields() throws {
        // Given
        let fields = Set(["Invalid"])
        let givenItem = CharacterFactory.make()
        var thrownError: Error?

        // When
        let featureGet = sut.getItem(on: eventLoop, withID: givenItem.id, fields: fields, from: table, logger: nil, dataSource: .database)
        XCTAssertThrowsError(try featureGet.wait()) {
            thrownError = $0
        }

        // Then
        let error = try XCTUnwrap(thrownError)
        if case let .invalidFields(invalidFields) = error as? ComicInfoError {
            XCTAssertEqual(invalidFields, ["Invalid"])
        } else {
            XCTFail("Expected '.invalidFields' but got \(error)")
        }
    }
    
    func testGetItem_whenOneOfFieldsIsInvalid_throwInvalidFields() throws {
        // Given
        let fields = Set(["series", "comics", "Invalid"])
        let givenItem = CharacterFactory.make()
        var thrownError: Error?

        // When
        let featureGet = sut.getItem(on: eventLoop, withID: givenItem.id, fields: fields, from: table, logger: nil, dataSource: .database)
        XCTAssertThrowsError(try featureGet.wait()) {
            thrownError = $0
        }

        // Then
        let error = try XCTUnwrap(thrownError)
        if case let .invalidFields(invalidFields) = error as? ComicInfoError {
            XCTAssertEqual(invalidFields, ["Invalid"])
        } else {
            XCTFail("Expected '.itemsNotFound' but got \(error)")
        }
    }

    func test_whenGetItemFromDatabase_returnsItem() throws {
        // Given
        let givenItem = CharacterFactory.make()

        // When
        let featureGet = sut.getItem(on: eventLoop, withID: givenItem.id, fields: nil, from: table, logger: nil, dataSource: .database)
        let item = try featureGet.wait()

        // Then
        XCTAssertEqual(item.id, givenItem.id)
    }
    
    func test_whenGetItemWithoutFields_returnsItemWithoutSummaries() throws {
        // Given
        let givenItem = CharacterFactory.make()

        // When
        let featureGet = sut.getItem(on: eventLoop, withID: givenItem.id, fields: nil, from: table, logger: nil, dataSource: .database)
        let item = try featureGet.wait()

        // Then
        XCTAssertNil(item.series)
        XCTAssertNil(item.comics)
    }
    
    func testGetItemWithFieldSeries_whenSeriesSummaryDoesntExist_returnsItemWithoutSummaries() throws {
        // Given
        let fields = Set(["series"])
        let givenItem = CharacterFactory.make()

        // When
        let featureGet = sut.getItem(on: eventLoop, withID: givenItem.id, fields: fields, from: table, logger: nil, dataSource: .database)
        let item = try featureGet.wait()

        // Then
        XCTAssertNil(item.series)
        XCTAssertEqual(item.id, givenItem.id)
    }
    
    func testGetItemWithFieldComics_whenComicsSummaryDoesntExist_returnsItemWithoutSummaries() throws {
        // Given
        let fields = Set(["comics"])
        let givenItem = CharacterFactory.make()

        // When
        let featureGet = sut.getItem(on: eventLoop, withID: givenItem.id, fields: fields, from: table, logger: nil, dataSource: .database)
        let item = try featureGet.wait()

        // Then
        XCTAssertNil(item.comics)
        XCTAssertEqual(item.id, givenItem.id)
    }
    
    func test_whenGetItemSeriesField_returnItemWithSeries() throws {
        // Given
        let fields = Set(["series"])
        
        var items = CharacterFactory.makeDatabaseItems()
        let seriesItems = SeriesFactory.makeDatabaseItems()
        for series in seriesItems {
            items[series.key] = series.value
        }
        
        sut = CharacterUseCaseFactoryMock(items: items).makeUseCase()
        
        let givenItem = CharacterFactory.make(seriesID: ["1"])
        let updateUseCase = CharacterUpdateUseCaseFactoryMock().makeUseCase()
        let criteria = UpdateItemCriteria(item: givenItem, oldSortValue: givenItem.sortValue, on: eventLoop, in: table)
        try updateUseCase.update(with: criteria).wait()

        // When
        let featureGet = sut.getItem(
            on: eventLoop,
            withID: givenItem.id,
            fields: fields,
            from: table,
            logger: nil,
            dataSource: .database
        )
        let item = try featureGet.wait()

        // Then
        XCTAssertEqual(item.series?.first?.itemID, "SeriesSummary#1")
        XCTAssertEqual(item.series?.first?.summaryID, "CharacterSummary#1")
    }
    
    func test_whenGetItemComicsField_returnItemWithComics() throws {
        // Given
        let fields = Set(["comics"])
        
        var items = CharacterFactory.makeDatabaseItems()
        let comicItems = ComicFactory.makeDatabaseItems()
        for comic in comicItems {
            items[comic.key] = comic.value
        }
        
        sut = CharacterUseCaseFactoryMock(items: items).makeUseCase()
        
        let givenItem = CharacterFactory.make(comicsID: ["1"])
        let updateUseCase = CharacterUpdateUseCaseFactoryMock().makeUseCase()
        let criteria = UpdateItemCriteria(item: givenItem, oldSortValue: givenItem.sortValue, on: eventLoop, in: table)
        try updateUseCase.update(with: criteria).wait()

        // When
        let featureGet = sut.getItem(on: eventLoop, withID: givenItem.id, fields: fields, from: table, logger: nil, dataSource: .database)
        let item = try featureGet.wait()

        // Then
        XCTAssertEqual(item.comics?.first?.itemID, "ComicSummary#1")
        XCTAssertEqual(item.comics?.first?.summaryID, "CharacterSummary#1")
    }
    
    func testGetItem_whenFieldsAreSeriesAndComics_returnItemWithSeriesAndComics() throws {
        // Given
        let fields = Set(["series", "comics"])
        
        var items = CharacterFactory.makeDatabaseItems()
        let seriesItems = SeriesFactory.makeDatabaseItems()
        for series in seriesItems {
            items[series.key] = series.value
        }
        
        let comicItems = ComicFactory.makeDatabaseItems()
        for comic in comicItems {
            items[comic.key] = comic.value
        }

        
        sut = CharacterUseCaseFactoryMock(items: items).makeUseCase()
        
        let givenItem = CharacterFactory.make(seriesID: ["1"], comicsID: ["1"])
        let updateUseCase = CharacterUpdateUseCaseFactoryMock().makeUseCase()
        let criteria = UpdateItemCriteria(item: givenItem, oldSortValue: givenItem.sortValue, on: eventLoop, in: table)
        try updateUseCase.update(with: criteria).wait()

        // When
        let featureGet = sut.getItem(on: eventLoop, withID: givenItem.id, fields: fields, from: table, logger: nil, dataSource: .database)
        let item = try featureGet.wait()

        // Then
        XCTAssertEqual(item.series?.first?.itemID, "SeriesSummary#1")
        XCTAssertEqual(item.comics?.first?.itemID, "ComicSummary#1")
    }

    func test_whenGetAllItemsFromDatabase_returnsItems() throws {
        // Given
        MockDB.removeAll()
        let givenCharacters = CharacterFactory.makeList
        let givenItems = CharacterFactory.makeDatabaseItemsList()
        sut = CharacterUseCaseFactoryMock(items: givenItems).makeUseCase()

        // When
        let featureGet = sut.getAllItems(
            on: eventLoop,
            afterID: nil,
            fields: nil,
            limit: 100,
            from: table,
            logger: nil,
            dataSource: .database
        )
        let items = try featureGet.wait()

        // Then
        XCTAssertEqual(items.map { $0.id }.sorted(by: <), givenCharacters.map { $0.id }.sorted(by: <))
    }

}
