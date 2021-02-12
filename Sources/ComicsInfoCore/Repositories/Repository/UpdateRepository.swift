//
//  UpdateRepository.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 07/01/2021.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation
import NIO

public final class UpdateRepository {

    private let dataProvider: UpdateDataProvider

    init(dataProvider: UpdateDataProvider) {
        self.dataProvider = dataProvider
    }

    public func update<Item: ComicInfoItem>(_ item: Item, in table: String) -> EventLoopFuture<Set<String>> {
        dataProvider.update(item, in: table)
    }
    
    public func updateSummaries<Summary: ItemSummary>(
        _ summaries: [Summary],
        in table: String,
        strategy: UpdateSummariesStrategy = .default
    ) -> EventLoopFuture<Void> {
        dataProvider.updateSummaries(summaries, in: table, strategy: strategy)
    }

}
