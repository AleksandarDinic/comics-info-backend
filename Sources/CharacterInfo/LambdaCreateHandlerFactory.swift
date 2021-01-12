//
//  LambdaCreateHandlerFactory.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 08/01/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import AWSLambdaRuntime
import ComicsInfoCore
import Foundation
import struct Logging.Logger
import protocol NIO.EventLoop

enum LambdaCreateHandlerFactory {

    static func makeHandler(_ context: Lambda.InitializationContext) -> Lambda.Handler {
        let useCaseFactory = makeUseCaseFactory(on: context.eventLoop, logger: context.logger)
        return CreateLambdaHandler(context, useCase: useCaseFactory.makeUseCase())
    }

    private static func makeUseCaseFactory(
        on eventLoop: EventLoop,
        logger: Logger
    ) -> CharacterCreateUseCaseFactory {
        CharacterCreateUseCaseFactory(
            on: eventLoop,
            isLocalServer: LocalServer.isEnabled,
            logger: logger
        )
    }

}
