//
//  GetCharacterLinks.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 12/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation
import NIO

protocol GetCharacterLinks: GetCharacterSummaries, GetSeries, GetComics {
    
    func getLinks(
        for item: Character,
        on eventLoop: EventLoop,
        in table: String
    ) -> EventLoopFuture<([Series], [Comic])>
    
}

extension GetCharacterLinks {
    
    func getLinks(
        for item: Character,
        on eventLoop: EventLoop,
        in table: String
    ) -> EventLoopFuture<([Series], [Comic])> {
        getSeries(on: eventLoop, forIDs: item.seriesID, from: table)
            .and(getComics(on: eventLoop, forIDs: item.comicsID, from: table))
            .and(getSummaries(item, on: eventLoop, in: table))
            .flatMapThrowing { (arg0, summaries) -> ([Series], [Comic]) in
                let (series, comic) = arg0
                guard let summaries = summaries else { return (series, comic) }
                
                throw ComicInfoError.summariesAlreadyExist(Set(summaries.map { $0.itemID }))
            }
    }
    
}
