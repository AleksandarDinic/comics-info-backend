//
//  CharacterGetAllMetadataAPIWrapperTests.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 21/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import XCTest

final class CharacterGetAllMetadataAPIWrapperTests: XCTestCase, CreateCharacterProtocol, CreateSeriesProtocol, CreateComicProtocol {

    private var sut: CharacterGetAllMetadataAPIWrapper!
    private var table: String!

    override func setUpWithError() throws {
        _ = LocalServer(enabled: true)
        DatabaseMock.removeAll()
        sut = CharacterGetAllMetadataAPIWrapperMock.make(tables: [:])
        table = String.tableName(for: "TEST")
    }

    override func tearDownWithError() throws {
        sut = nil
        table = nil
    }

    func test_whenGetAllMetadata_returnsAllMetadata() throws {
        // Given
        let series = SeriesMock.makeSeries(id: "1")
        try createSeries(series)
        let comic = ComicMock.makeComic(id: "1")
        try createComic(comic)
        try createCharacter(CharacterMock.makeCharacter(id: "1", seriesID: [series.id]))
        try createCharacter(CharacterMock.makeCharacter(id: "2", comicsID: [comic.id]))

        // When
        let feature = sut.getAllMetadata(ids: ["1", "2"], from: table)
        let characters = try feature.wait()

        // Then
        XCTAssertEqual(characters.map { $0.id }.sorted(by: <), ["1", "2"])
    }

    func test_whenGetAllMetadata_throwsItemsNotFound() throws {
        // Given
        var thrownError: Error?

        // When
        let feature = sut.getAllMetadata(ids: ["1", "2"], from: table)
        XCTAssertThrowsError(try feature.wait()) {
            thrownError = $0
        }

        // Then
        let error = try XCTUnwrap(thrownError)
        if case .itemsNotFound(let itemIDs, let itemType) = error as? APIError {
            XCTAssertEqual(itemIDs, ["1", "2"])
            XCTAssertTrue(itemType == Character.self)
        } else {
            XCTFail("Expected '.itemsNotFound' but got \(error)")
        }
    }

}
