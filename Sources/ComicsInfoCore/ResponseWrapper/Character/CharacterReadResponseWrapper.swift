//
//  CharacterReadResponseWrapper.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 09/09/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
import Foundation
import NIO

public struct CharacterReadResponseWrapper<APIWrapper: RepositoryAPIWrapper, CacheProvider: Cacheable>: ReadResponseWrapper where APIWrapper.Item == Character, CacheProvider.Item == Character {

    private let characterUseCase: CharacterUseCase<APIWrapper, CacheProvider>

    public init(characterUseCase: CharacterUseCase<APIWrapper, CacheProvider>) {
        self.characterUseCase = characterUseCase
    }

    public func handleRead(
        on eventLoop: EventLoop,
        request: Request,
        environment: String?
    ) -> EventLoopFuture<Response> {
        guard let id = request.pathParameters?["id"] else {
            let response = Response(statusCode: .badRequest)
            return eventLoop.makeSucceededFuture(response)
        }
        
        let fields = getFields(from: request.pathParameters)

        let table = String.tableName(for: environment)
        return characterUseCase.getItem(on: eventLoop, withID: id, fields: fields, from: table)
            .map { Response(with: Domain.Character(from: $0), statusCode: .ok) }
            .flatMapErrorThrowing { self.catch($0) }
    }
    
}
