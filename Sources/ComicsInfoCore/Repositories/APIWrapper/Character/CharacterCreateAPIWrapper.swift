//
//  CharacterCreateAPIWrapper.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 02/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Logging
import Foundation
import NIO

struct CharacterCreateAPIWrapper: CreateAPIWrapper, SeriesSummaryFuturesFactory, ComicSummaryFuturesFactory {

    typealias Summary = CharacterSummary
    typealias ItemDatabase = CharacterDatabase

    let seriesUseCase: SeriesUseCase<SeriesRepositoryAPIWrapper, InMemoryCacheProvider<Series>>
    let comicUseCase: ComicUseCase<ComicRepositoryAPIWrapper, InMemoryCacheProvider<Comic>>
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
        seriesUseCase = SeriesUseCaseFactory<InMemoryCacheProvider<Series>>(
            on: eventLoop,
            isLocalServer: LocalServer.isEnabled,
            cacheProvider: LocalServer.seriesInMemoryCache,
            logger: logger
        ).makeUseCase()
        comicUseCase = ComicUseCaseFactory<InMemoryCacheProvider<Comic>>(
            on: eventLoop,
            isLocalServer: LocalServer.isEnabled,
            cacheProvider: LocalServer.comicInMemoryCache,
            logger: logger
        ).makeUseCase()
    }

    func getSummaryFutures(for item: Character) -> [EventLoopFuture<[DatabasePutItem]>] {
        [
            getSeriesSummary(forIDs: item.seriesID, character: item),
            getComicsSummary(forIDs: item.comicsID, character: item)
        ]
    }

    // MARK: SeriesSummary

    func getSeriesSummary(
        forIDs seriesID: Set<String>?,
        character: Character
    ) -> EventLoopFuture<[DatabasePutItem]> {
        getSeries(seriesID).flatMapThrowing {
            guard !$0.isEmpty else { return [] }
            var dbItems: [DatabasePutItem] = makeSeriesSummary($0, item: character)
            return appendItemSummary($0, item: character, dbItems: &dbItems)
        }
    }

    // MARK: ComicsSummary

    private func getComicsSummary(
        forIDs comicsId: Set<String>?,
        character: Character
    ) -> EventLoopFuture<[DatabasePutItem]> {
        getComics(comicsId).flatMapThrowing {
            guard !$0.isEmpty else { return [] }
            var dbItems: [DatabasePutItem] = makeComicsSummary($0, item: character)
            return appendItemSummary($0, item: character, dbItems: &dbItems)
        }
    }

}
