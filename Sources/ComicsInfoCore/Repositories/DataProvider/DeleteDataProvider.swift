//
//  DeleteDataProvider.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 31/03/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation
import NIO

struct DeleteDataProvider {

    let itemDeleteDBWrapper: ItemDeleteDBWrapper

    func delete<Item: ComicInfoItem>(_ query: DeleteItemQuery<Item>) -> EventLoopFuture<Item> {
        itemDeleteDBWrapper.delete(query)
    }
    
    func deleteSummaries<Summary: ItemSummary>(_ query: DeleteSummariesQuery<Summary>) -> EventLoopFuture<[Summary]> {
        itemDeleteDBWrapper.deleteSummaries(query)
    }

}
