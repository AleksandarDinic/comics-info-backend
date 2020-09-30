//
//  SeriesReadResponseWrapper.swift
//  SeriesInfo
//
//  Created by Aleksandar Dinic on 25/09/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
import Foundation
import NIO

public struct SeriesReadResponseWrapper<APIWrapper: RepositoryAPIWrapper, CacheProvider: Cacheable>: ReadResponseWrapper where APIWrapper.Item == Series, CacheProvider.Item == Series {

    private let seriesUseCase: SeriesUseCase<APIWrapper, CacheProvider>

    public init(seriesUseCase: SeriesUseCase<APIWrapper, CacheProvider>) {
        self.seriesUseCase = seriesUseCase
    }

    public func handleRead(
        on eventLoop: EventLoop,
        request: Request
    ) -> EventLoopFuture<Response> {
        guard let id = request.pathParameters?["id"] else {
            let response = Response(statusCode: .notFound)
            return eventLoop.makeSucceededFuture(response)
        }

        return seriesUseCase.getItem(withID: id, fromDataSource: .memory)
            .map { Response(with: Domain.Series(from: $0), statusCode: .ok) }
            .flatMapError { self.catch($0, on: eventLoop) }
    }

}

