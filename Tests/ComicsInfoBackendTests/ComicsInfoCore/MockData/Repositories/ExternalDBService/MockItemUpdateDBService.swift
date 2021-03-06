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
    
    func update<Item: ComicInfoItem>(_ query: UpdateItemQuery<Item>) -> EventLoopFuture<Item> {
        guard TestDatabase.items[query.id] != nil, let itemData = try? JSONEncoder().encode(query.item) else {
            return eventLoop.makeFailedFuture(DatabaseError.itemNotFound(withID: query.id))
        }
        
        TestDatabase.items[query.id] = itemData
        return eventLoop.submit { query.item }
    }
    
    func updateSummaries<Summary: ItemSummary>(
        _ query: UpdateSummariesQuery<Summary>
    ) -> EventLoopFuture<[Summary]> {
        
        for summary in query.summaries {
            guard let summaryData = try? JSONEncoder().encode(summary) else { continue }
            TestDatabase.items[query.getID(for: summary)] = summaryData
        }

        return eventLoop.submit { query.summaries }
    }
    
}
