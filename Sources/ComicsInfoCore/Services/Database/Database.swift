//
//  Database.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 27/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation
import NIO

public protocol Database {

    mutating func create(_ item: DatabasePutItem) -> EventLoopFuture<Void>
    mutating func createAll(_ items: [DatabasePutItem]) -> EventLoopFuture<Void>

    func getItem(withID itemID: String) -> EventLoopFuture<[DatabaseItem]>
    func getAll(_ items: String) -> EventLoopFuture<[DatabaseItem]>

    func getMetadata(withID id: String) -> EventLoopFuture<DatabaseItem>
    func getAllMetadata(withIDs ids: Set<String>) -> EventLoopFuture<[DatabaseItem]>

    func getAllSummaries(forID summaryID: String) -> EventLoopFuture<[DatabaseItem]>

    mutating func update(_ items: [DatabaseUpdateItem]) -> EventLoopFuture<Void>

}
