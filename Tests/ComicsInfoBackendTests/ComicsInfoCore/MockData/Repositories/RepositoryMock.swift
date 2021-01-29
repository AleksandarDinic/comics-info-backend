//
//  RepositoryMock.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 20/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import Foundation
import Logging
import NIO

enum RepositoryMock {

    static func makeCharacterRepository(
        on eventLoop: EventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1).next(),
        cacheProvider: InMemoryCacheProvider<Character> = InMemoryCacheProvider<Character>(),
        items: [String: Data]
    ) -> Repository<CharacterRepositoryAPIWrapper, InMemoryCacheProvider<Character>> {
        let dataProvider = DataProviderMock.makeCharacterDataProvider(
            on: eventLoop,
            cacheProvider: cacheProvider,
            items: items
        )
        return Repository(dataProvider: dataProvider)
    }
    
    static func makeCharacterRepositoryUpdate(
        on eventLoop: EventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1).next(),
        cacheProvider: InMemoryCacheProvider<Character> = InMemoryCacheProvider<Character>(),
        items: [String: Data]
    ) -> UpdateRepository<CharacterUpdateRepositoryAPIWrapper> {
        let dataProvider = DataProviderMock.makeCharacterUpdateDataProvider(
            on: eventLoop,
            items: items
        )
        return UpdateRepository(dataProvider: dataProvider)
    }

}
