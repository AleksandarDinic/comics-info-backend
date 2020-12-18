//
//  Repository.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 24/09/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation
import NIO

public final class Repository<APIWrapper: RepositoryAPIWrapper, CacheProvider: Cacheable> where APIWrapper.Item == CacheProvider.Item {

    public typealias Item = APIWrapper.Item

    private let dataProvider: DataProvider<APIWrapper, CacheProvider>

    init(dataProvider: DataProvider<APIWrapper, CacheProvider>) {
        self.dataProvider = dataProvider
    }

    /// Create item.
    ///
    /// - Parameter item: The item.
    /// - Returns: Future with Item value.
    public func create(
        _ item: Item,
        in table: String
    ) -> EventLoopFuture<Void> {
        dataProvider.create(item, in: table)
    }

    /// Gets item.
    ///
    /// - Parameters:
    ///   - itemID: Item ID.
    ///   - dataSource: Layer of data source.
    /// - Returns: Future with Item value.
    public func getItem(
        withID itemID: Item.ID,
        fromDataSource dataSource: DataSourceLayer,
        from table: String
    ) -> EventLoopFuture<Item> {
        dataProvider.getItem(
            withID: itemID,
            fromDataSource: dataSource,
            from: table
        )
    }

    /// Gets all items.
    ///
    /// - Parameter dataSource: Layer of data source.
    /// - Returns: Future with Items value.
    public func getAllItems(
        fromDataSource dataSource: DataSourceLayer,
        from table: String
    ) -> EventLoopFuture<[Item]> {
        dataProvider.getAllItems(fromDataSource: dataSource, from: table)
    }

    /// Gets item metadata.
    ///
    /// - Parameters:
    ///   - id: Item ID.
    ///   - dataSource: Layer of data source
    /// - Returns: Future with Item metadata.
    public func getMetadata(
        withID id: Item.ID,
        fromDataSource dataSource: DataSourceLayer,
        from table: String
    ) -> EventLoopFuture<Item> {
        dataProvider.getMetadata(
            withID: id,
            fromDataSource: dataSource,
            from: table
        )
    }

    /// Gets items metadata.
    ///
    /// - Parameters:
    ///   - ids: List of items ID.
    ///   - dataSource: Layer of data source
    /// - Returns: Future with Items metadata.
    public func getAllMetadata(
        withIDs ids: Set<Item.ID>,
        fromDataSource dataSource: DataSourceLayer,
        from table: String
    ) -> EventLoopFuture<[Item]> {
        dataProvider.getAllMetadata(
            withIDs: ids,
            fromDataSource: dataSource,
            from: table
        )
    }

    /// Update item.
    ///
    /// - Parameter item: The item.
    /// - Returns: Future with Item value.
    public func update(
        _ item: Item,
        in table: String
    ) -> EventLoopFuture<Void> {
        dataProvider.update(item, in: table)
    }

}