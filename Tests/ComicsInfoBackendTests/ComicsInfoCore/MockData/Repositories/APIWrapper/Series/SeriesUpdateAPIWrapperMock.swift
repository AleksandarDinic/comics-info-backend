//
//  SeriesUpdateAPIWrapperMock.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 22/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import Foundation
import Logging
import NIO

enum SeriesUpdateAPIWrapperMock {

    static func make(
        on eventLoop: EventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1).next(),
        logger: Logger = Logger(label: "SeriesCreateAPIWrapperMock"),
        encoderService: EncoderService = EncoderProvider(),
        decoderService: DecoderService = DecoderProvider(),
        tables: [String: TableMock]
    ) -> SeriesUpdateAPIWrapper {
        SeriesUpdateAPIWrapper(
            eventLoop: eventLoop,
            repositoryAPIService: RepositoryAPIServiceMock.makeRepositoryUpdateAPIService(
                on: eventLoop,
                logger: logger,
                tables: tables
            ),
            encoderService: encoderService,
            decoderService: decoderService,
            characterUseCase: CharacterUseCaseFactoryMock(tables: tables).makeUseCase(),
            comicUseCase: ComicUseCaseFactoryMock().makeUseCase()
        )
    }

}
