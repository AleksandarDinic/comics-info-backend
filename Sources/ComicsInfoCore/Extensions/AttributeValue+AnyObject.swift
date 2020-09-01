//
//  AttributeValue+AnyObject.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 27/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import AWSDynamoDB
import Foundation

extension DynamoDB.AttributeValue {

    var value: Any? {
        switch self {
        case let .b(value):
            return value

        case let .bool(value):
            return value

        case let .bs(value):
            return value

        case let .l(value):
            return value

        case let .m(value):
            return value.mapValues { $0.value }

        case let .n(value):
            guard let valueInt = Int(value) else {
                return Double(value)
            }
            return valueInt

        case let .ns(value):
            let valueInt = value.compactMap { Int($0) }

            guard !valueInt.isEmpty else {
                return value.compactMap { Double($0) }
            }

            return valueInt

        case let .null(value):
            return value

        case let .s(value):
            return value

        case let .ss(value):
            return value

        }
    }

}
