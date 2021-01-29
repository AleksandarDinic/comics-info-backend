//
//  InMemoryCacheService.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 24/09/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol Cacheable {

    associatedtype Item: ComicInfoItem

    func getItem(withID itemID: Item.ID, from table: String) -> Result<Item, CacheError<Item>>
    func getItems(withIDs IDs: Set<Item.ID>, from table: String) -> (items: [Item], missingIDs: Set<Item.ID>)
    func getAllItems(from table: String) -> Result<[Item], CacheError<Item>>

    func save(items: [Item], in table: String)
    
    func getSummaries<Summary: ItemSummary>(
        _ type: Summary.Type,
        forID ID: String,
        from table: String
    ) -> Result<[Summary], CacheError<Item>>
    
    func save<Summary: ItemSummary>(summaries: [Summary], in table: String)

}
