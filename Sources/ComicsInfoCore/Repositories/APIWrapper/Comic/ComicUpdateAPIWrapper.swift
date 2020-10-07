//
//  ComicUpdateAPIWrapper.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 06/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Logging
import Foundation
import NIO

struct ComicUpdateAPIWrapper: UpdateAPIWrapper, CharacterSummaryFuturesFactory, SeriesSummaryFuturesFactory {

    typealias Summary = ComicSummary
    typealias ItemDatabase = ComicDatabase

    let characterUseCase: CharacterUseCase<CharacterRepositoryAPIWrapper, InMemoryCacheProvider<Character>>
    let seriesUseCase: SeriesUseCase<SeriesRepositoryAPIWrapper, InMemoryCacheProvider<Series>>

    let eventLoop: EventLoop
    let repositoryAPIService: RepositoryAPIService
    let encoderService: EncoderService
    let decoderService: DecoderService

    init(
        on eventLoop: EventLoop,
        repositoryAPIService: RepositoryAPIService,
        encoderService: EncoderService,
        decoderService: DecoderService,
        logger: Logger
    ) {
        self.eventLoop = eventLoop
        self.repositoryAPIService = repositoryAPIService
        self.encoderService = encoderService
        self.decoderService = decoderService
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

    func getSummaryFutures(for item: Comic) -> [EventLoopFuture<[DatabaseUpdateItem]>] {
        [
            getCharactersSummary(forIDs: item.charactersID, comic: item),
            getSeriesSummary(forIDs: item.seriesID, comic: item)
        ]
    }

    // MARK: CharactersSummary

    private func getCharactersSummary(
        forIDs charactersId: Set<String>?,
        comic: Comic
    ) -> EventLoopFuture<[DatabaseUpdateItem]> {
        getCharacters(charactersId).flatMapThrowing {
            guard !$0.isEmpty else { return [] }
            var dbItems: [DatabaseUpdateItem] = makeCharactersSummary($0, item: comic)
            return appendItemSummary($0, item: comic, dbItems: &dbItems)
        }
    }

    // MARK: SeriesSummary

    private func getSeriesSummary(
        forIDs seriesID: Set<String>?,
        comic: Comic
    ) -> EventLoopFuture<[DatabaseUpdateItem]> {
        getSeries(seriesID).flatMapThrowing {
            guard !$0.isEmpty else { return [] }
            var dbItems: [DatabaseUpdateItem] = makeSeriesSummary($0, item: comic)
            return appendItemSummary($0, item: comic, dbItems: &dbItems)
        }
    }

}
