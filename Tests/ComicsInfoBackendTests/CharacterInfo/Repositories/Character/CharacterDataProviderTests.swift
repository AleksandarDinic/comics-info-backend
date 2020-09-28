//
//  CharacterDataProviderTests.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 02/09/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
@testable import CharacterInfo
import XCTest
import NIO

final class CharacterDataProviderTests: XCTestCase {

    private var eventLoop: EventLoop!
    private var characterID: String!
    private var characterDataProviderMockFactory: CharacterDataProviderMockFactory!

    override func setUpWithError() throws {
        eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1).next()
        characterDataProviderMockFactory = CharacterDataProviderMockFactory(on: eventLoop)
        characterID = "1"
    }

    override func tearDownWithError() throws {
        eventLoop = nil
        characterDataProviderMockFactory = nil
        characterID = nil
    }

    // MARK: - Characters

    func test_whenGetAllCharactersFromDatabase_returns3Characters() throws {
        // Given
        let sut = characterDataProviderMockFactory.makeWithCharactersFromDatabase()
        let dataSourceLayer = DataSourceLayer.database

        // When
        let charactersFuture = sut.getAllCharacters(fromDataSource: dataSourceLayer, on: eventLoop)

        // Then
        let characters = try charactersFuture.wait()
        XCTAssertEqual(characters.count, 3)
    }

    func test_whenGetAllCharactersFromMemory_returns3Characters() throws {
        // Given
        let sut = characterDataProviderMockFactory.makeWithCharactersFromMemory()
        let dataSourceLayer = DataSourceLayer.memory

        // When
        let charactersFuture = sut.getAllCharacters(fromDataSource: dataSourceLayer, on: eventLoop)

        // Then
        let characters = try charactersFuture.wait()
        XCTAssertEqual(characters.count, 3)
    }

    func test_whenGetAllCharactersFromEmptyMemory_returns3CharactersFromDatabase() throws {
        // Given
        let sut = characterDataProviderMockFactory.makeWithCharactersFromDatabase()
        let dataSourceLayer = DataSourceLayer.memory

        // When
        let charactersFuture = sut.getAllCharacters(fromDataSource: dataSourceLayer, on: eventLoop)

        // Then
        let characters = try charactersFuture.wait()
        XCTAssertEqual(characters.count, 3)
    }

    func testWithoutData_whenGetAllCharacters_throwsNoItem() {
        // Given
        let sut = characterDataProviderMockFactory.makeWithoutData()
        let dataSourceLayer = DataSourceLayer.database

        // When
        let charactersFuture = sut.getAllCharacters(fromDataSource: dataSourceLayer, on: eventLoop)

        // Then
        XCTAssertThrowsError(try charactersFuture.wait()) {
            XCTAssertEqual($0 as? APIError, .itemsNotFound)
        }
    }

    // MARK: - Character

    func test_whenGetCharacterFromDatabase_returnsCharacter() throws {
        // Given
        let sut = characterDataProviderMockFactory.makeWithCharacterFromDatabase()
        let dataSourceLayer = DataSourceLayer.database

        // When
        let characterFuture = sut.getCharacter(withID: characterID, fromDataSource: dataSourceLayer, on: eventLoop)

        // Then
        let character = try characterFuture.wait()
        XCTAssertEqual(character.identifier, characterID)
    }

    func test_whenGetCharacterFromMemory_returnsCharacter() throws {
        // Given
        let sut = characterDataProviderMockFactory.makeWithCharacterFromMemory()
        let dataSourceLayer = DataSourceLayer.memory

        // When
        let characterFuture = sut.getCharacter(withID: characterID, fromDataSource: dataSourceLayer, on: eventLoop)

        // Then
        let character = try characterFuture.wait()
        XCTAssertEqual(character.identifier, characterID)
    }

    func test_whenGetCharacterFromEmptyMemory_returnsCharacterFromDatabase() throws {
        // Given
        let sut = characterDataProviderMockFactory.makeWithCharacterFromDatabase()
        let dataSourceLayer = DataSourceLayer.memory

        // When
        let characterFuture = sut.getCharacter(withID: characterID, fromDataSource: dataSourceLayer, on: eventLoop)

        // Then
        let character = try characterFuture.wait()
        XCTAssertEqual(character.identifier, characterID)
    }

    func testWithoutData_whenGetCharacter_throwsNoItem() {
        // Given
        let sut = characterDataProviderMockFactory.makeWithoutData()
        let dataSourceLayer = DataSourceLayer.database

        // When
        let characterFuture = sut.getCharacter(withID: characterID, fromDataSource: dataSourceLayer, on: eventLoop)

        // Then
        XCTAssertThrowsError(try characterFuture.wait()) {
            XCTAssertEqual($0 as? APIError, .itemNotFound)
        }
    }

}
