//
//  CreateCharacterLinksSummaries.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 12/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation
import NIO

protocol CreateCharacterLinksSummaries: CreateCharacterSummariesForSeries, CreateCharacterSummariesForComics {
    
    func createLinksSummaries(
        for item: Character,
        series: [Series],
        comics: [Comic],
        on eventLoop: EventLoop,
        in table: String
    ) -> EventLoopFuture<Void>
    
}

extension CreateCharacterLinksSummaries {
    
    func createLinksSummaries(
        for item: Character,
        series: [Series],
        comics: [Comic],
        on eventLoop: EventLoop,
        in table: String
    ) -> EventLoopFuture<Void> {
        createSummaries(for: series, item: item, on: eventLoop, in: table)
            .and(createSummaries(for: comics, item: item, on: eventLoop, in: table))
            .map { _ in }
    }
    
}
