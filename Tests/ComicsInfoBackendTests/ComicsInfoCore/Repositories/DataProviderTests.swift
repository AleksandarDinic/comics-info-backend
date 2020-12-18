//
//  DataProviderTests.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 19/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import XCTest

final class DataProviderTests: XCTestCase {

    private var sut: DataProvider<CharacterRepositoryAPIWrapper, InMemoryCacheProvider<Character>>!
    private var table: String!

    override func setUpWithError() throws {
        _ = LocalServer(enabled: true)
        DatabaseMock.removeAll()
        sut = DataProviderMock.makeCharacterDataProvider()
        table = String.tableName(for: "TEST")
    }

    override func tearDownWithError() throws {
        sut = nil
        table = nil
    }

    // MARK: - Create

    func test_whenCreateItem_itemIsCreated() throws {
        // Given
        let givenItem = CharacterMock.makeCharacter()

        // When
        let feature = sut.create(givenItem, in: table)

        // Then
        XCTAssertNoThrow(try feature.wait())
    }

    // MARK: - Get All

    func test_whenGetAllItemsFromDatabase_returnsItems() throws {
        // Given
        let givenItems = CharacterMock.charactersList
        for givenItem in givenItems {
            let feature = sut.create(givenItem, in: table)
            try feature.wait()
        }

        // When
        let featureGet = sut.getAllItems(fromDataSource: .database, from: table)
        let items = try featureGet.wait()

        // Then
        XCTAssertEqual(items.map { $0.id }.sorted(by: <), givenItems.map { $0.id }.sorted(by: <))
    }

    func test_whenGetAllItemsFromMemoryWithEmptyMomory_returnsItems() throws {
        // Given
        let givenItems = CharacterMock.charactersList
        for givenItem in givenItems {
            let feature = sut.create(givenItem, in: table)
            try feature.wait()
        }

        // When
        let featureGet = sut.getAllItems(fromDataSource: .memory, from: table)
        let items = try featureGet.wait()

        // Then
        XCTAssertEqual(items.map { $0.id }.sorted(by: <), givenItems.map { $0.id }.sorted(by: <))
    }

    func test_whenGetAllItemsFromMemory_returnsItems() throws {
        // Given
        let givenItems = CharacterMock.charactersList
        let cache = InMemoryCacheProvider<Character>()
        cache.save(items: givenItems, in: table)
        sut = DataProviderMock.makeCharacterDataProvider(cacheProvider: cache)

        // When
        let featureGet = sut.getAllItems(fromDataSource: .memory, from: table)
        let items = try featureGet.wait()

        // Then
        XCTAssertEqual(items.map { $0.id }.sorted(by: <), givenItems.map { $0.id }.sorted(by: <))
    }

    // MARK: - Get Item

    func test_whenGetItemFromDatabase_returnsItem() throws {
        // Given
        let givenItem = CharacterMock.makeCharacter()
        let feature = sut.create(givenItem, in: table)
        try feature.wait()

        // When
        let featureGet = sut.getItem(withID: givenItem.id, fromDataSource: .database, from: table)
        let item = try featureGet.wait()

        // Then
        XCTAssertEqual(item.id, givenItem.id)
    }

    func test_whenGetItemFromMemoryWithEmptyMomory_returnsItem() throws {
        // Given
        let givenItem = CharacterMock.makeCharacter()
        let feature = sut.create(givenItem, in: table)
        try feature.wait()

        // When
        let featureGet = sut.getItem(withID: givenItem.id, fromDataSource: .memory, from: table)
        let item = try featureGet.wait()

        // Then
        XCTAssertEqual(item.id, givenItem.id)
    }

    func test_whenGetItemFromMemory_returnsItem() throws {
        // Given
        let givenItem = CharacterMock.makeCharacter()
        let cache = InMemoryCacheProvider<Character>()
        cache.save(items: [givenItem], in: table)
        sut = DataProviderMock.makeCharacterDataProvider(cacheProvider: cache)

        // When
        let featureGet = sut.getItem(withID: givenItem.id, fromDataSource: .memory, from: table)
        let item = try featureGet.wait()

        // Then
        XCTAssertEqual(item.id, givenItem.id)
    }

    // MARK: - Get Metadata

    func test_whenGetMetadataFromDatabase_returnsMetadata() throws {
        // Given
        let givenItem = CharacterMock.makeCharacter()
        let feature = sut.create(givenItem, in: table)
        try feature.wait()

        // When
        let featureGet = sut.getMetadata(withID: givenItem.id, fromDataSource: .database, from: table)
        let item = try featureGet.wait()

        // Then
        XCTAssertEqual(item.id, givenItem.id)
    }

    func test_whenGetMetadataFromMemoryWithEmptyMomory_returnsMetadata() throws {
        // Given
        let givenItem = CharacterMock.makeCharacter()
        let feature = sut.create(givenItem, in: table)
        try feature.wait()

        // When
        let featureGet = sut.getMetadata(withID: givenItem.id, fromDataSource: .memory, from: table)
        let item = try featureGet.wait()

        // Then
        XCTAssertEqual(item.id, givenItem.id)
    }

    func test_whenGetMetadaFromMemory_returnsMetada() throws {
        // Given
        let givenItem = CharacterMock.makeCharacter()
        let cache = InMemoryCacheProvider<Character>()
        cache.save(items: [givenItem], in: table)
        sut = DataProviderMock.makeCharacterDataProvider(cacheProvider: cache)

        // When
        let featureGet = sut.getMetadata(withID: givenItem.id, fromDataSource: .memory, from: table)
        let item = try featureGet.wait()

        // Then
        XCTAssertEqual(item.id, givenItem.id)
    }

    // MARK: - Get All Metadata

    func test_whenGetAllMetadataFromDatabase_returnsAllMetadata() throws {
        // Given
        let givenItems = CharacterMock.charactersList
        for givenItem in givenItems {
            let feature = sut.create(givenItem, in: table)
            try feature.wait()
        }

        // When
        let featureGet = sut.getAllMetadata(withIDs: Set(givenItems.map { $0.id }), fromDataSource: .database, from: table)
        let items = try featureGet.wait()

        // Then
        XCTAssertEqual(items.map { $0.id }.sorted(by: <), givenItems.map { $0.id }.sorted(by: <))
    }

    func test_whenGetAllMetadataFromMemoryWithEmptyMomory_returnsAllMetata() throws {
        // Given
        let givenItems = CharacterMock.charactersList
        for givenItem in givenItems {
            let feature = sut.create(givenItem, in: table)
            try feature.wait()
        }

        // When
        let featureGet = sut.getAllMetadata(withIDs: Set(givenItems.map { $0.id }), fromDataSource: .memory, from: table)
        let items = try featureGet.wait()

        // Then
        XCTAssertEqual(items.map { $0.id }.sorted(by: <), givenItems.map { $0.id }.sorted(by: <))
    }

    func test_whenGetAllMetadataFromMemory_returnsMetadata() throws {
        // Given
        let givenItems = CharacterMock.charactersList
        let cache = InMemoryCacheProvider<Character>()
        cache.save(items: givenItems, in: table)
        sut = DataProviderMock.makeCharacterDataProvider(cacheProvider: cache)

        // When
        let featureGet = sut.getAllMetadata(withIDs: Set(givenItems.map { $0.id }), fromDataSource: .memory, from: table)
        let items = try featureGet.wait()

        // Then
        XCTAssertEqual(items.map { $0.id }.sorted(by: <), givenItems.map { $0.id }.sorted(by: <))
    }

    // MARK: - Update

    func test_whenUpdateItem_itemUpdated() throws {
        // Given
        let givenItem = CharacterMock.makeCharacter()
        let feature = sut.create(givenItem, in: table)
        try feature.wait()

        let updateItem = CharacterMock.makeCharacter(name: "New name")
        // When
        let featureUpdate = sut.update(updateItem, in: table)

        // Then
        XCTAssertNoThrow(try featureUpdate.wait())
    }

}