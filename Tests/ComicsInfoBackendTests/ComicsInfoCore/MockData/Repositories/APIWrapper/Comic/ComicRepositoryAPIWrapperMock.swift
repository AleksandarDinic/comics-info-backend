//
//  ComicRepositoryAPIWrapperMock.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 22/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import Foundation
import Logging
import NIO

enum ComicRepositoryAPIWrapperMock {

    static func make(
        on eventLoop: EventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1).next(),
        logger: Logger = Logger(label: "ComicRepositoryAPIWrapperMock"),
        tables: [String: TableMock],
        decoderService: DecoderService = DecoderProvider()
    ) -> ComicRepositoryAPIWrapper {
        ComicRepositoryAPIWrapper(
            repositoryAPIService: RepositoryAPIServiceMock.makeRepositoryAPIService(
                on: eventLoop,
                logger: logger,
                tables: tables
            ),
            decoderService: decoderService
        )
    }

}
