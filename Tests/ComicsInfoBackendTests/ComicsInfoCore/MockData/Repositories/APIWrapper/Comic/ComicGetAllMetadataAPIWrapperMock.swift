//
//  ComicGetAllMetadataAPIWrapperMock.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 21/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import Foundation
import Logging
import NIO

enum ComicGetAllMetadataAPIWrapperMock {

    static func make(
        on eventLoop: EventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1).next(),
        logger: Logger = Logger(label: "ComicCreateAPIWrapperMock"),
        tables: [String: TableMock],
        decoderService: DecoderService = DecoderProvider()
    ) -> ComicGetAllMetadataAPIWrapper {
        let repositoryAPIService = RepositoryAPIServiceMock.makeRepositoryAPIService(
            on: eventLoop,
            logger: logger,
            tables: tables
        )
        return ComicGetAllMetadataAPIWrapper(
            repositoryAPIService: repositoryAPIService,
            decoderService: decoderService
        )
    }

}
