//
//  UseCaseTests.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 16/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import Logging
import NIO
import XCTest

final class UseCaseTests: XCTestCase {

    private var eventLoop: EventLoop!
    private var logger: Logger!
    private var sut: CharacterUseCase<CharacterRepositoryAPIWrapper, InMemoryCacheProvider<Character>>!
    private var table: String!

    override func setUpWithError() throws {
        _ = LocalServer(enabled: true)
        DatabaseMock.removeAll()
        eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1).next()
        logger = Logger(label: self.className)
        table = String.tableName(for: "TEST")
    }

    override func tearDownWithError() throws {
        eventLoop = nil
        logger = nil
        sut = nil
        table = nil
    }

    func test_whenGetItemFromDatabase_returnsItem() throws {
        // Given
        let givenItem = CharacterMock.makeCharacter()
        let items = CharacterMock.makeDatabaseItems(table)
        sut = CharacterUseCaseFactoryMock(items: items, on: eventLoop, logger: logger).makeUseCase()

        // When
        let featureGet = sut.getItem(withID: givenItem.id, fromDataSource: .database, from: table)
        let item = try featureGet.wait()

        // Then
        XCTAssertEqual(item.id, givenItem.id)
    }

    func test_whenGetAllItemsFromDatabase_returnsItems() throws {
        // Given
        let givenCharacters = CharacterMock.charactersList
        let givenItems = CharacterMock.makeDatabaseItemsList(table)
        sut = CharacterUseCaseFactoryMock(items: givenItems, on: eventLoop, logger: logger).makeUseCase()

        // When
        let featureGet = sut.getAllItems(fromDataSource: .database, from: table)
        let items = try featureGet.wait()

        // Then
        XCTAssertEqual(items.map { $0.id }.sorted(by: <), givenCharacters.map { $0.id }.sorted(by: <))
    }

    func test_whenGetMetadataFromDatabase_returnsMetadata() throws {
        // Given
        let givenItem = CharacterMock.makeCharacter()
        let items = CharacterMock.makeDatabaseItems(table)
        sut = CharacterUseCaseFactoryMock(items: items, on: eventLoop, logger: logger).makeUseCase()

        // When
        let featureGet = sut.getMetadata(withID: givenItem.id, fromDataSource: .database, from: table)
        let item = try featureGet.wait()

        // Then
        XCTAssertEqual(item.id, givenItem.id)
    }

    func test_whenGetAllMetadataFromDatabase_returnsAllMetadata() throws {
        // Given
        let givenCharacters = CharacterMock.charactersList
        let givenItems = CharacterMock.makeDatabaseItemsList(table)
        sut = CharacterUseCaseFactoryMock(items: givenItems, on: eventLoop, logger: logger).makeUseCase()

        // When
        let featureGet = sut.getAllMetadata(withIDs: Set(givenCharacters.map { $0.id }), fromDataSource: .database, from: table)
        let items = try featureGet.wait()

        // Then
        XCTAssertEqual(items.map { $0.id }.sorted(by: <), givenCharacters.map { $0.id }.sorted(by: <))
    }

}
