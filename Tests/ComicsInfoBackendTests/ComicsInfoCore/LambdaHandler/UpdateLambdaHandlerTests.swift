//
//  UpdateLambdaHandlerTests.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 08/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import Logging
import NIO
import XCTest

final class UpdateLambdaHandlerTests: XCTestCase, LambdaMockFactory {

    private var eventLoop: EventLoop!
    private var request: Request!
    private var logger: Logger!

    override func setUpWithError() throws {
        _ = LocalServer(enabled: true)
        MockDB.removeAll()
        eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1).next()
        request = Request(body: CharacterFactory.requestBody)
        logger = Logger(label: self.className)
    }

    override func tearDownWithError() throws {
        eventLoop = nil
        request = nil
        logger = nil
    }

    func test_whenHandle_responseStatusIsOk() throws {
        // Given
        let useCase = CharacterUpdateUseCaseFactoryMock(
            items: CharacterFactory.makeDatabaseItems(),
            on: eventLoop
        ).makeUseCase()
        let updateResponseWrapper = CharacterUpdateResponseWrapper(characterUseCase: useCase)
        let sut = UpdateLambdaHandler(
            makeLambdaInitializationContext(logger: logger, on: eventLoop),
            updateResponseWrapper: updateResponseWrapper
        )

        // When
        let responseFuture = sut.handle(context: makeLambdaContext(logger: logger, on: eventLoop), event: request)

        // Then
        let response = try responseFuture.wait()
        XCTAssertEqual(response.statusCode.code, ComicsInfoCore.HTTPResponseStatus.ok.code)
    }

}
