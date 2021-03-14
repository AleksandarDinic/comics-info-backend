//
//  ComicListResponseWrapper.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 05/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
import struct Logging.Logger
import Foundation
import NIO

public struct ComicListResponseWrapper: GetQueryParameterSeriesID, ListResponseWrapper {

    private let comicUseCase: ComicUseCase

    public init(comicUseCase: ComicUseCase) {
        self.comicUseCase = comicUseCase
    }

    public func handleList(
        on eventLoop: EventLoop,
        request: Request,
        environment: String?,
        logger: Logger?
    ) -> EventLoopFuture<Response> {
        do {
            let table = String.tableName(for: environment)
            let fields = getFields(from: request.queryParameters)
            let seriesID = try getSeriesID(from: request.queryParameters)
        
            return comicUseCase.getAllItems(
                on: eventLoop,
                summaryID: seriesID,
                fields: fields,
                from: table,
                logger: logger
            )
                .map { Response(with: $0.map { Domain.Comic(from: $0) }, statusCode: .ok) }
                .flatMapErrorThrowing { self.catch($0) }
        } catch {
            guard let responseError = error as? ComicInfoError else {
                let message = ResponseStatus(error.localizedDescription)
                return eventLoop.submit { Response(with: message, statusCode: .badRequest) }
            }
            
            let message = ResponseStatus(for: responseError)
            return eventLoop.submit { Response(with: message, statusCode: responseError.responseStatus) }
        }
    }

}
