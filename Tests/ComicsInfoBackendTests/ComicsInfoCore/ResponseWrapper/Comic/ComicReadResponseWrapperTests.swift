//
//  ComicReadResponseWrapperTests.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 21/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import XCTest
import NIO

final class ComicReadResponseWrapperTests: XCTestCase, CreateComicProtocol {

    private typealias Cache = InMemoryCacheProvider<Comic>

    private var eventLoop: EventLoop!
    private var sut: ComicReadResponseWrapper<ComicRepositoryAPIWrapper, Cache>!
    private var environment: String!

    override func setUpWithError() throws {
        _ = LocalServer(enabled: true)
        DatabaseMock.removeAll()
        eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1).next()
        let useCase = ComicUseCaseFactoryMock(on: eventLoop).makeUseCase()
        sut = ComicReadResponseWrapper(comicUseCase: useCase)
        environment = "TEST"
    }

    override func tearDownWithError() throws {
        eventLoop = nil
        sut = nil
        environment = nil
    }

    func test_whenHandleReadWithoutPathParameters_statusIsBadRequest() throws {
        // Given
        let request = Request(pathParameters: nil, body: nil)

        // When
        let feature = sut.handleRead(on: eventLoop, request: request, environment: environment)
        let response = try feature.wait()

        // Then
        XCTAssertEqual(response.statusCode.code, ComicsInfoCore.HTTPResponseStatus.badRequest.code)
    }

    func test_whenHandleReadWithInvalidPathParameters_statusIsBadRequest() throws {
        // Given
        let request = Request(pathParameters: ["invalidID": "-1"], body: nil)

        // When
        let feature = sut.handleRead(on: eventLoop, request: request, environment: environment)
        let response = try feature.wait()

        // Then
        XCTAssertEqual(response.statusCode.code, ComicsInfoCore.HTTPResponseStatus.badRequest.code)
    }

    func test_whenHandleReadWithoutItems_statusIsNotFound() throws {
        // Given
        let request = Request(pathParameters: ["id": "1"], body: nil)

        // When
        let feature = sut.handleRead(on: eventLoop, request: request, environment: environment)
        let response = try feature.wait()

        // Then
        XCTAssertEqual(response.statusCode.code, ComicsInfoCore.HTTPResponseStatus.notFound.code)
    }


    func test_whenHandleList_statusIsOk() throws {
        // Given
        try createComic(ComicMock.makeComic())
        let request = Request(pathParameters: ["id": "1"], body: nil)

        // When
        let feature = sut.handleRead(on: eventLoop, request: request, environment: environment)
        let response = try feature.wait()

        // Then
        XCTAssertEqual(response.statusCode.code, ComicsInfoCore.HTTPResponseStatus.ok.code)
    }

}
