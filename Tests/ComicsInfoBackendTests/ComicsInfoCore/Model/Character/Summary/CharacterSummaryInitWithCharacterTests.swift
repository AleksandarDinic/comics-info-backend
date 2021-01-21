//
//  CharacterSummaryInitWithCharacterTests.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 14/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import XCTest

final class CharacterSummaryInitWithCharacterTests: XCTestCase {

    private var character: Character!
    private var itemName: String!
    private var summaryName: String!
    private var id: String!
    private var sut: CharacterSummary!

    override func setUpWithError() throws {
        character = CharacterMock.character
        itemName = "series"
        summaryName = "character"
        id = "2"
        sut = CharacterSummary(character, id: id, itemName: itemName)
    }

    override func tearDownWithError() throws {
        character = nil
        itemName = nil
        id = nil
        sut = nil
    }

    func testID_whenInitWithCharacter_isEqualToCharacterID() {
        XCTAssertEqual(sut.id, character.id)
    }

    func testPopularity_whenInitWithCharacter_isEqualToCharacterPopularity() {
        XCTAssertEqual(sut.popularity, character.popularity)
    }

    func testName_whenInitWithCharacter_isEqualToCharacterName() {
        XCTAssertEqual(sut.name, character.name)
    }
    
    func testDateAdded_whenInitWithCharacter_isEqualToCharacterDateAdded() {
        XCTAssertNotEqual(sut.dateAdded, character.dateAdded)
    }
    
    func testDateLastUpdated_whenInitWithCharacter_isEqualToCharacterDateLastUpdated() {
        XCTAssertNotEqual(sut.dateLastUpdated, character.dateLastUpdated)
    }

    func testThumbnail_whenInitWithCharacter_isEqualToCharacterThumbnail() {
        XCTAssertEqual(sut.thumbnail, character.thumbnail)
    }

    func testDescription_whenInitWithCharacter_isEqualToCharacterDescription() {
        XCTAssertEqual(sut.description, character.description)
    }

    func testItemName_whenInitWithCharacter_isEqualToItemName() {
        XCTAssertEqual(sut.itemName, itemName)
    }
    
    func testSummaryName_whenInitWithCharacter_isEqualToSummaryName() {
        XCTAssertEqual(sut.summaryName, summaryName)
    }

    func testItemID_whenInitWithCharacter_isEqualToItemID() throws {
        let itemName = try XCTUnwrap(self.itemName)
        let id = try XCTUnwrap(self.id)
        XCTAssertEqual(sut.itemID, "\(itemName)#\(id)")
    }

    func testSummaryID_whenInitWithCharacter_isEqualToSummaryID() {
        XCTAssertEqual(sut.summaryID, "character#\(character.id)")
    }

}
