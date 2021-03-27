//
//  CreateSeriesLinksSummaries.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 12/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import struct Logging.Logger
import Foundation
import NIO

protocol CreateSeriesLinksSummaries: CreateSeriesSummariesForCharacters, CreateSeriesSummariesForComics {
    
    func createLinksSummaries(
        for item: Series,
        characters: [Character],
        comics: [Comic],
        on eventLoop: EventLoop,
        in table: String,
        logger: Logger?
    ) -> EventLoopFuture<([CharacterSummary], [ComicSummary])?>
    
}

extension CreateSeriesLinksSummaries {
    
    func createLinksSummaries(
        for item: Series,
        characters: [Character],
        comics: [Comic],
        on eventLoop: EventLoop,
        in table: String,
        logger: Logger?
    ) -> EventLoopFuture<([CharacterSummary], [ComicSummary])?> {
        createSummaries(for: characters, item: item, on: eventLoop, in: table, logger: logger)
            .and(createSummaries(for: comics, item: item, on: eventLoop, in: table, logger: logger))
            .map {
                guard let characterSummaries = $0?.0, let comicSummaries = $1?.0 else {
                    return nil
                }
                return (characterSummaries, comicSummaries)
            }
    }
    
}
