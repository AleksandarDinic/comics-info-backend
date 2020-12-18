//
//  RepositoryAPIWrapperMock.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 19/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import Foundation
import Logging
import NIO

enum RepositoryAPIWrapperMock {

    static func makeCharacterRepositoryAPIWrapper(
        on eventLoop: EventLoop,
        logger: Logger,
        decoderService: DecoderService = DecoderProvider(),
        encoderService: EncoderService = EncoderProvider()
    ) -> CharacterRepositoryAPIWrapper {
        CharacterRepositoryAPIWrapper(
            on: eventLoop,
            repositoryAPIService: RepositoryAPIServiceMock.makeRepositoryAPIService(
                on: eventLoop,
                logger: logger
            ),
            logger: logger,
            decoderService: decoderService,
            encoderService: encoderService
        )
    }

}
