//
//  CreateCharacterLinksSummaries.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 12/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import struct Logging.Logger
import Foundation
import NIO

protocol CreateCharacterLinksSummaries: CreateCharacterSummariesForSeries, CreateCharacterSummariesForComics {
    
    func createLinksSummaries(
        for item: Character,
        series: [Series],
        comics: [Comic],
        on eventLoop: EventLoop,
        in table: String,
        logger: Logger?
    ) -> EventLoopFuture<([SeriesSummary], [ComicSummary])?>
    
}

extension CreateCharacterLinksSummaries {
    
    func createLinksSummaries(
        for item: Character,
        series: [Series],
        comics: [Comic],
        on eventLoop: EventLoop,
        in table: String,
        logger: Logger?
    ) -> EventLoopFuture<([SeriesSummary], [ComicSummary])?> {
        createSummaries(for: series, item: item, on: eventLoop, in: table, logger: logger)
            .and(createSummaries(for: comics, item: item, on: eventLoop, in: table, logger: logger))
            .map {
                guard let seriesSummaries = $0?.0, let comicSummaries = $1?.0 else {
                    return nil
                }
                return (seriesSummaries, comicSummaries)
            }
    }
    
}
