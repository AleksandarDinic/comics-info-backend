//
//  ComicCreateAPIWrapper.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 05/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Logging
import Foundation
import NIO

struct ComicCreateAPIWrapper: CreateAPIWrapper, CharacterSummaryFuturesFactory, SeriesSummaryFuturesFactory {

    typealias Summary = ComicSummary
    typealias ItemDatabase = ComicDatabase

    let characterUseCase: CharacterUseCase<CharacterRepositoryAPIWrapper, InMemoryCacheProvider<Character>>
    let seriesUseCase: SeriesUseCase<SeriesRepositoryAPIWrapper, InMemoryCacheProvider<Series>>
    let repositoryAPIService: RepositoryAPIService
    let encoderService: EncoderService
    let eventLoop: EventLoop

    init(
        on eventLoop: EventLoop,
        repositoryAPIService: RepositoryAPIService,
        encoderService: EncoderService,
        logger: Logger
    ) {
        self.repositoryAPIService = repositoryAPIService
        self.encoderService = encoderService
        self.eventLoop = eventLoop
        characterUseCase = CharacterUseCaseFactory<InMemoryCacheProvider<Character>>(
            on: eventLoop,
            isLocalServer: LocalServer.isEnabled,
            cacheProvider: LocalServer.characterInMemoryCache,
            logger: logger
        ).makeUseCase()
        seriesUseCase = SeriesUseCaseFactory<InMemoryCacheProvider<Series>>(
            on: eventLoop,
            isLocalServer: LocalServer.isEnabled,
            cacheProvider: LocalServer.seriesInMemoryCache,
            logger: logger
        ).makeUseCase()
    }

    func getSummaryFutures(for item: Comic) -> [EventLoopFuture<[DatabasePutItem]>] {
        [
            getCharactersSummary(forIDs: item.charactersID, comic: item),
            getSeriesSummary(forIDs: item.seriesID, comic: item)
        ]
    }

    // MARK: CharactersSummary

    private func getCharactersSummary(
        forIDs charactersID: Set<String>?,
        comic: Comic
    ) -> EventLoopFuture<[DatabasePutItem]> {
        getCharacters(charactersID).flatMapThrowing {
            guard !$0.isEmpty else { return [] }
            var dbItems: [DatabasePutItem] = makeCharactersSummary($0, item: comic)
            return appendItemSummary($0, item: comic, dbItems: &dbItems)
        }
    }

    // MARK: SeriesSummary

    private func getSeriesSummary(
        forIDs seriesID: Set<String>?,
        comic: Comic
    ) -> EventLoopFuture<[DatabasePutItem]> {
        getSeries(seriesID).flatMapThrowing {
            guard !$0.isEmpty else { return [] }
            var dbItems: [DatabasePutItem] = makeSeriesSummary($0, item: comic)
            return appendItemSummary($0, item: comic, dbItems: &dbItems)
        }
    }

}
