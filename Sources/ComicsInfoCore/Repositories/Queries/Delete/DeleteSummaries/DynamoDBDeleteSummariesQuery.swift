//
//  DynamoDBDeleteSummariesQuery.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 30/03/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation
import SotoDynamoDB

struct DynamoDBDeleteSummariesQuery<Summary: ItemSummary>: Loggable {
    
    let summaries: [Summary]
    let table: String
    
    var inputs: [(DynamoDB.DeleteItemInput, Summary)] {
        var inputs = [(DynamoDB.DeleteItemInput, Summary)]()
        
        for summary in summaries {
            let delete = DynamoDB.DeleteItemInput(
                key: ["itemID": .s(summary.itemID), "sortValue": .s(summary.oldSortValue ?? summary.sortValue)],
                tableName: table
            )
            inputs.append((delete, summary))
        }
        return inputs
    }
    
    func getLogs() -> [Log] {
        var logs = [Log("Update Summaries Query")]

        for input in inputs {
            logs.append(Log("Update Summaries input: \(input)"))
        }
        
        return logs
    }
    
}
