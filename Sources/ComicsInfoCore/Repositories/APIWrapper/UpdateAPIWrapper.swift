//
//  UpdateAPIWrapper.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 07/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation
import NIO

protocol UpdateAPIWrapper {

    associatedtype Item: ComicsInfoItem
    associatedtype Summary: ItemSummary where Summary.Item == Item
    associatedtype ItemDatabase: DatabaseMapper where ItemDatabase.Item == Item

    var eventLoop: EventLoop { get }
    var repositoryAPIService: RepositoryAPIService { get }
    var encoderService: EncoderService { get }
    var decoderService: DecoderService { get }

    func update(
        _ item: Item,
        in table: String
    ) -> EventLoopFuture<Void>

    func updateSummaries(
        for item: Item,
        in table: String
    ) -> EventLoopFuture<(DatabaseItems: [DatabaseUpdateItem], Item: Item)>

    func createSummaries(
        initialState: [DatabaseUpdateItem],
        futures: [EventLoopFuture<[DatabaseUpdateItem]>]
    ) -> EventLoopFuture<[DatabaseUpdateItem]>

    func getSummaryFutures(
        for item: Item,
        from table: String
    ) -> [EventLoopFuture<[DatabaseUpdateItem]>]

}

extension UpdateAPIWrapper {

    func update(
        _ item: Item,
        in table: String
    ) -> EventLoopFuture<Void> {
        updateSummaries(for: item, in: table)
            .flatMap { createSummaries(
                initialState: $0.DatabaseItems,
                futures: getSummaryFutures(for: $0.Item, from: table)
            ) }
            .flatMap { repositoryAPIService.update($0) }
            .flatMapErrorThrowing { throw $0.mapToAPIError(itemType: Item.self) }
    }

    func updateSummaries(
        for item: Item,
        in table: String
    ) -> EventLoopFuture<(DatabaseItems: [DatabaseUpdateItem], Item: Item)> {
        repositoryAPIService.getAllSummaries(forID: mapItemID(item.id), from: table)
            .flatMapThrowing { dbItems in
                var item = item
                var db = [DatabaseUpdateItem]()
                for dbItem in dbItems {
                    guard let updateItem = makeUpdateItem(dbItem, item: &item, table: table) else { continue }
                    db.append(updateItem)
                }

                db.append(createDatabaseItem(item, in: table))
                return (db, item)
            }
    }

    private func makeUpdateItem(_ dbItem: DatabaseItem, item: inout Item, table: String) -> DatabaseUpdateItem? {
        guard var summary: Summary = try? decoderService.decode(from: dbItem) else { return nil }
        guard summary.itemID != summary.summaryID else { return nil }
        item.removeID(summary.itemID)
        guard summary.shouldBeUpdated(with: item) else { return nil }

        summary.update(with: item)
        return encoderService.encode(summary, table: table)
    }

    private func createDatabaseItem(_ item: Item, in table: String) -> DatabaseUpdateItem {
        encoderService.encode(ItemDatabase(item: item), table: table)
    }

    func createSummaries(
        initialState: [DatabaseUpdateItem],
        futures: [EventLoopFuture<[DatabaseUpdateItem]>]
    ) -> EventLoopFuture<[DatabaseUpdateItem]> {
        .reduce(initialState, futures, on: eventLoop) { $0 + $1 }
    }

    private func mapItemID(_ id: Item.ID) -> String {
        "\(String.getType(from: Item.self))#\(id)"
    }

    func appendItemSummary<LinkItem: Identifiable>(
        _ linkItems: [LinkItem],
        item: Item,
        dbItems: inout [DatabaseUpdateItem],
        tableName: String
    ) -> [DatabaseUpdateItem] where LinkItem.ID == String {

        for linkItem in linkItems {
            let summary = Summary(item, id: linkItem.id, itemName: .getType(from: LinkItem.self))
            dbItems.append(encoderService.encode(summary, table: tableName, conditionExpression: nil))
        }

        return dbItems
    }

}