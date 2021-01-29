//
//  DatabaseUpdate.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 08/01/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation
import NIO

public protocol DatabaseUpdate {

    func update<Item: ComicInfoItem>(_ item: Item, in table: String) -> EventLoopFuture<Set<String>>
    func updateSummaries<Summary: ItemSummary>(_ items: [Summary], in table: String) -> EventLoopFuture<Void>
    
}
