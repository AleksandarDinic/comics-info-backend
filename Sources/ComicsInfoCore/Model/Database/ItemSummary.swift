//
//  ItemSummary.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 07/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol ItemSummary: DatabaseDecodable {

    associatedtype Item: Identifiable

    init(_ item: Item, id: String, itemName: String, tableName: String)

    mutating func update(with item: Item)
    func shouldBeUpdated(with item: Item) -> Bool

}
