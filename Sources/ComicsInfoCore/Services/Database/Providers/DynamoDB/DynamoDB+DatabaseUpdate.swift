//
//  DynamoDB+DatabaseUpdate.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 11/01/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import AsyncHTTPClient
import Foundation
import SotoDynamoDB

extension DynamoDB: DatabaseUpdate {

    public func update<Item: Codable & Identifiable>(_ item: Item, in table: String) -> EventLoopFuture<Set<String>> {
        let input = UpdateItemCodableInput(
            conditionExpression: "attribute_exists(itemID) AND attribute_exists(summaryID)",
            key: ["itemID", "summaryID"],
            returnValues: .updatedOld,
            tableName: table,
            updateItem: item
        )

        DynamoDB.logger.log(level: .info, "Update input: \(input)")
        return updateItem(input).flatMapThrowing {
            DynamoDB.logger.log(level: .info, "Update output: \($0)")
            guard let keys = $0.attributes?.keys else { return [] }
            return Set(keys)
        }
    }
    
    public func updateSummaries<Summary: ItemSummary>(_ summaries: [Summary], in table: String) -> EventLoopFuture<Void> {
        let input = UpdateItemCodableInput(
            key: ["itemID", "summaryID"],
            tableName: table,
            updateItem: summaries
        )
        
        DynamoDB.logger.log(level: .info, "Update input: \(input)")
        return updateItem(input).flatMapThrowing {
            DynamoDB.logger.log(level: .info, "Update output: \($0)")
        }
    }
    
}
