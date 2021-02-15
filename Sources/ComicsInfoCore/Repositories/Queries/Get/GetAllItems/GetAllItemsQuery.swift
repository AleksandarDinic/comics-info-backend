//
//  GetAllItemsQuery.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 15/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import struct Logging.Logger
import Foundation

public struct GetAllItemsQuery: LoggerProvider {
    
    let items: String
    let table: String
    let logger: Logger?
    
    var dynamoDBQuery: DynamoDBGetAllItemsQuery {
        let query = DynamoDBGetAllItemsQuery(items: items, table: table)
        
        guard let logger = logger else {
            return query
        }
        return log(logger, loggable: query)
    }
            
}
