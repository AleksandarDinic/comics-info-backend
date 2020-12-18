//
//  DatabaseDecoder.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 30/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public struct DatabaseDecoder {

    private let item: DatabaseItem

    public init(from item: DatabaseItem) {
        self.item = item
    }

    public func decode<T>(_ type: T.Type, forKey key: CodingKey) throws -> T {
        guard let item = item[key.stringValue] else {
            throw DecodingError.keyNotFound(
                key,
                DecodingError.Context(
                    codingPath: [key],
                    debugDescription: "No value associated with key \(key)"
                )
            )
        }

        guard let decodeItem = item as? T else {
            throw DecodingError.typeMismatch(
                T.self,
                DecodingError.Context(
                    codingPath: [key],
                    debugDescription: "Expected to decode \(T.self) but found a \(Swift.type(of: item)) instead."
                )
            )
        }

        return decodeItem
    }

}