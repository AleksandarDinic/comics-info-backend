//
//  SeriesRepositoryAPIWrapperMock.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 22/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import Foundation
import Logging
import NIO

enum SeriesRepositoryAPIWrapperMock {

    static func make(
        on eventLoop: EventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1).next(),
        logger: Logger = Logger(label: "SeriesRepositoryAPIWrapperMock"),
        decoderService: DecoderService = DecoderProvider(),
        items: [String: TableMock]
    ) -> SeriesRepositoryAPIWrapper {
        SeriesRepositoryAPIWrapper(
            repositoryAPIService: RepositoryAPIServiceMock.makeRepositoryAPIService(
                on: eventLoop,
                logger: logger,
                items: items
            ),
            decoderService: decoderService
        )
    }

}
