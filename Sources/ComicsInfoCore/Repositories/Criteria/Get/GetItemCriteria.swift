//
//  GetItemCriteria.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 04/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import struct Logging.Logger
import Foundation

public struct GetItemCriteria {
    
    let ID: String
    let dataSource: DataSourceLayer
    let table: String
    let logger: Logger?
    
    init(
        ID: String,
        dataSource: DataSourceLayer,
        table: String,
        logger: Logger? = nil
    ) {
        self.ID = ID
        self.dataSource = dataSource
        self.table = table
        self.logger = logger
    }
    
}
