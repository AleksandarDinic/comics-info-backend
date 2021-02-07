//
//  MockItemUpdateDBService.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 05/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import Foundation
import NIO

struct MockItemUpdateDBService: ItemUpdateDBService {
    
    private var eventLoop: EventLoop
    
    init(
        on eventLoop: EventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1).next(),
        items: [String: Data] = [:]
    ) {
        self.eventLoop = eventLoop
        
        for item in items {
            TestDatabase.items[item.key] = item.value
        }
    }
    
    func update<Item: ComicInfoItem>(_ item: Item, in table: String) -> EventLoopFuture<Set<String>> {
        guard let oldItemData = TestDatabase.items[item.itemID],
              let oldItem = try? JSONDecoder().decode(Item.self, from: oldItemData),
              let itemData = try? JSONEncoder().encode(item) else {
            return eventLoop.makeFailedFuture(DatabaseError.itemNotFound(withID: item.itemID))
        }
        
        TestDatabase.items[item.itemID] = itemData
        return eventLoop.submit { item.updatedFields(old: oldItem) }
    }
    
    func updateSummaries<Summary: ItemSummary>(_ summaries: [Summary], in table: String) -> EventLoopFuture<Void> {
        for summary in summaries {
            guard let summaryData = try? JSONEncoder().encode(summary) else { continue }
            TestDatabase.items["\(summary.itemID)|\(summary.summaryID)"] = summaryData
        }

        return eventLoop.submit { }
    }
    
}
