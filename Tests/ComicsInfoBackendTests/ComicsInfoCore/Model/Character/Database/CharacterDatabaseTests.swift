//
//  CharacterDatabaseTests.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 13/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import XCTest

final class CharacterDatabaseTests: XCTestCase {

    private var givenCharacter: Character!
    private var sut: CharacterDatabase!

    override func setUpWithError() throws {
        givenCharacter = CharacterMock.character
        sut = CharacterDatabase(item: givenCharacter, tableName: "character")
    }

    override func tearDownWithError() throws {
        givenCharacter = nil
        sut = nil
    }

    func testID() {
        XCTAssertEqual(sut.id, "1")
    }

    func testTableName_isEqualToCharacter() {
        XCTAssertEqual(sut.tableName, "character")
    }

    func testItemID_whenInitFromCharacter_isEqualToItemID() {
        XCTAssertEqual(sut.itemID, "character#1")
    }

    func testSummaryID_whenInitFromCharacter_isEqualToSummaryID() {
        XCTAssertEqual(sut.summaryID, "character#1")
    }

    func testItemName_whenInitFromCharacter_isEqualToItemName() {
        XCTAssertEqual(sut.itemName, "character")
    }

    func testGetSeriesSummaryID_whenInitFromCharacter_isEqualToSeriesID() {
        XCTAssertEqual(sut.getSeriesID(), ["2", "3", "4"])
    }

    func testGetSeriesSummaryID_whenInitFromCharacter_seriesIDIsNil() {
        // Given
        givenCharacter = CharacterMock.makeCharacter()

        // When
        sut = CharacterDatabase(item: givenCharacter, tableName: "character")

        // Then
        XCTAssertNil(sut.getSeriesID())
    }

    func testGetComicsSummaryID_whenInitFromCharacter_isEqualToComicsID() {
        XCTAssertEqual(sut.getComicsID(), ["2", "3", "4"])
    }

    func testGetComicsSummaryID_whenInitFromCharacter_comicsIDIsNil() {
        // Given
        givenCharacter = CharacterMock.makeCharacter()

        // When
        sut = CharacterDatabase(item: givenCharacter, tableName: "character")

        // Then
        XCTAssertNil(sut.getComicsID())
    }

    func testID_whenInitFromCharacter_isEqualToCharacterID() {
        XCTAssertEqual(sut.id, givenCharacter.id)
    }

    func testPopularity_whenInitFromCharacter_isEqualToCharacterPopularity() {
        XCTAssertEqual(sut.popularity, givenCharacter.popularity)
    }

    func testName_whenInitFromCharacter_isEqualToCharacterName() {
        XCTAssertEqual(sut.name, givenCharacter.name)
    }

    func testThumbnail_whenInitFromCharacter_isEqualToCharacterThumbnail() {
        XCTAssertEqual(sut.thumbnail, givenCharacter.thumbnail)
    }

    func testDescription_whenInitFromCharacter_isEqualToCharacterDescription() {
        XCTAssertEqual(sut.description, givenCharacter.description)
    }

    func testSeries_whenInitFromCharacter_isEqualToCharacterSeriesSummary() {
        XCTAssertEqual(sut.seriesSummary?.compactMap { $0.id }, givenCharacter.series?.compactMap { $0.id })
    }

    func testComics_whenInitFromCharacter_isEqualToCharacterComicsSummary() {
        XCTAssertEqual(sut.comicsSummary?.compactMap { $0.id }, givenCharacter.comics?.compactMap { $0.id })
    }

}
