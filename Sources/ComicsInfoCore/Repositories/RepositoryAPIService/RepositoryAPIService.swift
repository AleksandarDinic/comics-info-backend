//
//  RepositoryAPIService.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 24/09/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation
import NIO

public protocol RepositoryAPIService {

    func getItem(withID itemID: String, from table: String) -> EventLoopFuture<[DatabaseItem]>
    func getAll(_ items: String, from table: String) -> EventLoopFuture<[DatabaseItem]>

    func getMetadata(withID id: String, from table: String) -> EventLoopFuture<DatabaseItem>
    func getAllMetadata(withIDs ids: Set<String>, from table: String) -> EventLoopFuture<[DatabaseItem]>

}