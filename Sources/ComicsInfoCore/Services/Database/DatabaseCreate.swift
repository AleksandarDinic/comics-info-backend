//
//  DatabaseCreate.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 08/01/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation
import NIO

public protocol DatabaseCreate {

    mutating func create<Item: ComicInfoItem>(_ item: Item, in table: String) -> EventLoopFuture<Void>
    mutating func createSummaries<Summary: ItemSummary>(_ summaries: [Summary], in table: String) -> EventLoopFuture<Void>
    
}
