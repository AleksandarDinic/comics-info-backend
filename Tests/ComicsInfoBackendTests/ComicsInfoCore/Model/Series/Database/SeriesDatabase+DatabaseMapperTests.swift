//
//  SeriesDatabase+DatabaseMapperTests.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 15/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import XCTest

final class SeriesDatabase_DatabaseMapperTests: XCTestCase {

    private var databaseItem: DatabasePutItem!
    private var sut: SeriesDatabase!

    override func setUpWithError() throws {
        databaseItem = DatabasePutItem(SeriesMock.items, table: String.tableName(for: "TEST"))
    }

    override func tearDownWithError() throws {
        databaseItem = nil
        sut = nil
    }

    private func makeSeriesDatabaseFromDatabaseItem() throws -> SeriesDatabase {
        try SeriesDatabase(from: databaseItem)
    }

    // MARK: - Item ID

    func testItemID_whenInitFromDatabaseItem_isEqualToItemID() throws {
        // Given
        let itemID = "series#1"
        databaseItem.attributes["itemID"] = itemID

        // When
        sut = try makeSeriesDatabaseFromDatabaseItem()

        // Then
        XCTAssertEqual(sut.itemID, itemID)
    }

    func testSeriesDatabase_whenInitFromDatabaseItemWithMissingItemID_throwsKeyNotFound() throws {
        // Given
        databaseItem.attributes["itemID"] = nil
        var thrownError: Error?

        // When
        XCTAssertThrowsError(try makeSeriesDatabaseFromDatabaseItem()) {
            thrownError = $0
        }

        // Then
        let error = try XCTUnwrap(thrownError)
        if case .keyNotFound(let key, _) = error as? DecodingError {
            XCTAssertEqual(key.stringValue, SeriesDatabase.CodingKeys.itemID.stringValue)
        } else {
            XCTFail("Expected '.keyNotFound' but got \(error)")
        }
    }

    func testSeriesDatabase_whenInitFromDatabaseItemWithInvalidItemID_throwsInvalidItemID() throws {
        // Given
        databaseItem.attributes["itemID"] = "1"
        var thrownError: Error?

        // When
        XCTAssertThrowsError(try makeSeriesDatabaseFromDatabaseItem()) {
            thrownError = $0
        }

        // Then
        let error = try XCTUnwrap(thrownError)
        if case .invalidItemID(let itemID, let itemType) = error as? APIError {
            XCTAssertEqual(itemID, "1")
            XCTAssertEqual(itemType, "series")
        } else {
            XCTFail("Expected '.invalidItemID' but got \(error)")
        }
    }

    // MARK: - Summary ID

    func testSummaryID_whenInitFromDatabaseItem_isEqualToSummaryID() throws {
        // Given
        let summaryID = "series#1"
        databaseItem.attributes["summaryID"] = summaryID

        // When
        sut = try makeSeriesDatabaseFromDatabaseItem()

        // Then
        XCTAssertEqual(sut.summaryID, summaryID)
    }

    func testSeriesDatabase_whenInitFromDatabaseItemWithMissingSummaryID_throwsKeyNotFound() throws {
        // Given
        databaseItem.attributes["summaryID"] = nil
        var thrownError: Error?

        // When
        XCTAssertThrowsError(try makeSeriesDatabaseFromDatabaseItem()) {
            thrownError = $0
        }

        // Then
        let error = try XCTUnwrap(thrownError)
        if case .keyNotFound(let key, _) = error as? DecodingError {
            XCTAssertEqual(key.stringValue, SeriesDatabase.CodingKeys.summaryID.stringValue)
        } else {
            XCTFail("Expected '.keyNotFound' but got \(error)")
        }
    }

    func testSeriesDatabase_whenInitFromDatabaseItemWithInvalidSummaryID_throwsInvalidSummaryID() throws {
        // Given
        databaseItem.attributes["summaryID"] = "1"
        var thrownError: Error?

        // When
        XCTAssertThrowsError(try makeSeriesDatabaseFromDatabaseItem()) {
            thrownError = $0
        }

        // Then
        let error = try XCTUnwrap(thrownError)
        if case .invalidSummaryID(let itemID, let itemType) = error as? APIError {
            XCTAssertEqual(itemID, "1")
            XCTAssertEqual(itemType, "series")
        } else {
            XCTFail("Expected '.invalidItemID' but got \(error)")
        }
    }

    // MARK: - Item Name

    func testItemName_whenInitFromDatabaseItem_isEqualToItemName() throws {
        // Given
        let itemName = "series"
        databaseItem.attributes["itemName"] = itemName

        // When
        sut = try makeSeriesDatabaseFromDatabaseItem()

        // Then
        XCTAssertEqual(sut.itemName, itemName)
    }

    func testSeriesDatabase_whenInitFromDatabaseItemWithMissingItemName_throwsKeyNotFound() throws {
        // Given
        databaseItem.attributes["itemName"] = nil
        var thrownError: Error?

        // When
        XCTAssertThrowsError(try makeSeriesDatabaseFromDatabaseItem()) {
            thrownError = $0
        }

        // Then
        let error = try XCTUnwrap(thrownError)
        if case .keyNotFound(let key, _) = error as? DecodingError {
            XCTAssertEqual(key.stringValue, SeriesDatabase.CodingKeys.itemName.stringValue)
        } else {
            XCTFail("Expected '.keyNotFound' but got \(error)")
        }
    }

    // MARK: - Popularity

    func testPopularity_whenInitFromDatabaseItem_isEqualToPopularity() throws {
        // Given
        let popularity = 0
        databaseItem.attributes["popularity"] = popularity

        // When
        sut = try makeSeriesDatabaseFromDatabaseItem()

        // Then
        XCTAssertEqual(sut.popularity, popularity)
    }

    func testSeriesDatabase_whenInitFromDatabaseItemWithMissingPopularity_throwsKeyNotFound() throws {
        // Given
        databaseItem.attributes["popularity"] = nil
        var thrownError: Error?

        // When
        XCTAssertThrowsError(try makeSeriesDatabaseFromDatabaseItem()) {
            thrownError = $0
        }

        // Then
        let error = try XCTUnwrap(thrownError)
        if case .keyNotFound(let key, _) = error as? DecodingError {
            XCTAssertEqual(key.stringValue, SeriesDatabase.CodingKeys.popularity.stringValue)
        } else {
            XCTFail("Expected '.keyNotFound' but got \(error)")
        }
    }

    // MARK: - Title

    func testTitle_whenInitFromDatabaseItem_isEqualToTitle() throws {
        // Given
        let title = "Series Title"
        databaseItem.attributes["title"] = title

        // When
        sut = try makeSeriesDatabaseFromDatabaseItem()

        // Then
        XCTAssertEqual(sut.title, title)
    }

    func testSeriesDatabase_whenInitFromDatabaseItemWithMissingTitle_throwsKeyNotFound() throws {
        // Given
        databaseItem.attributes["title"] = nil
        var thrownError: Error?

        // When
        XCTAssertThrowsError(try makeSeriesDatabaseFromDatabaseItem()) {
            thrownError = $0
        }

        // Then
        let error = try XCTUnwrap(thrownError)
        if case .keyNotFound(let key, _) = error as? DecodingError {
            XCTAssertEqual(key.stringValue, SeriesDatabase.CodingKeys.title.stringValue)
        } else {
            XCTFail("Expected '.keyNotFound' but got \(error)")
        }
    }
    
    // MARK: - Date Added

    func testDateAdded_whenInitFromDatabaseItem_isEqualToDateAdded() throws {
        // Given
        let dateAdded = Date()
        databaseItem.attributes["dateAdded"] = DateFormatter.defaultString(from: dateAdded)

        // When
        sut = try makeSeriesDatabaseFromDatabaseItem()

        // Then
        XCTAssertEqual(
            Calendar.current.dateComponents([.year, .month, .day], from: sut.dateAdded),
            Calendar.current.dateComponents([.year, .month, .day], from: dateAdded)
        )
    }
    
    // MARK: - Date Last Updated

    func testDateLastUpdated_whenInitFromDatabaseItem_isEqualToDateLastUpdated() throws {
        // Given
        let dateLastUpdated = Date()
        databaseItem.attributes["dateLastUpdated"] = DateFormatter.defaultString(from: dateLastUpdated)

        // When
        sut = try makeSeriesDatabaseFromDatabaseItem()

        // Then
        XCTAssertEqual(
            Calendar.current.dateComponents([.year, .month, .day], from: sut.dateLastUpdated),
            Calendar.current.dateComponents([.year, .month, .day], from: dateLastUpdated)
        )
    }

    // MARK: - Thumbnail

    func testThumbnail_whenInitFromDatabaseItem_isEqualToThumbnail() throws {
        // Given
        let thumbnail = "Series Thumbnail"
        databaseItem.attributes["thumbnail"] = thumbnail

        // When
        sut = try makeSeriesDatabaseFromDatabaseItem()

        // Then
        XCTAssertEqual(sut.thumbnail, thumbnail)
    }

    // MARK: - Description

    func testDescription_whenInitFromDatabaseItem_isEqualToDescription() throws {
        // Given
        let description = "Series Description"
        databaseItem.attributes["description"] = description

        // When
        sut = try makeSeriesDatabaseFromDatabaseItem()

        // Then
        XCTAssertEqual(sut.description, description)
    }

    // MARK: - Start Year

    func testStartYear_whenInitFromDatabaseItem_isEqualToStartYear() throws {
        // Given
        let startYear = 1
        databaseItem.attributes["startYear"] = startYear

        // When
        sut = try makeSeriesDatabaseFromDatabaseItem()

        // Then
        XCTAssertEqual(sut.startYear, startYear)
    }

    // MARK: - End Year

    func testEndYear_whenInitFromDatabaseItem_isEqualToEndYear() throws {
        // Given
        let endYear = 2
        databaseItem.attributes["endYear"] = endYear

        // When
        sut = try makeSeriesDatabaseFromDatabaseItem()

        // Then
        XCTAssertEqual(sut.endYear, endYear)
    }

    // MARK: - Aliases

    func testAliases_whenInitFromDatabaseItem_isEqualToAliases() throws {
        // Given
        let aliases = ["Series Aliases"]
        databaseItem.attributes["aliases"] = aliases

        // When
        sut = try makeSeriesDatabaseFromDatabaseItem()

        // Then
        XCTAssertEqual(sut.aliases, aliases)
    }

    // MARK: - Next Identifier

    func testNextIdentifier_whenInitFromDatabaseItem_isEqualToNextIdentifier() throws {
        // Given
        let nextIdentifier = "Series Next Identifier"
        databaseItem.attributes["nextIdentifier"] = nextIdentifier

        // When
        sut = try makeSeriesDatabaseFromDatabaseItem()

        // Then
        XCTAssertEqual(sut.nextIdentifier, nextIdentifier)
    }

}
