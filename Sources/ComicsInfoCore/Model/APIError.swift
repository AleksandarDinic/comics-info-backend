//
//  APIError.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 24/09/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public enum APIError: Error {

    case requestError
    case itemAlreadyExists(withID: String, itemType: Any.Type)
    case itemNotFound(withID: String, itemType: Any.Type)
    case itemsNotFound(withIDs: Set<String>?, itemType: Any.Type)
    case invalidItemID(_ itemID: String, itemType: String)
    case invalidSummaryID(_ summaryID: String, itemType: String)
    case handlerUnknown

}

extension APIError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .requestError:
            return "Request Error"

        case let .itemAlreadyExists(withID: id, itemType: itemType):
            return "\(String(describing: type(of: itemType.self))) already exists with id: \(id)"

        case let .itemNotFound(id, itemType):
            return "We couldn't find \(String(describing: type(of: itemType.self))) with id: \(id)"

        case let .itemsNotFound(ids, itemType):
            let desc = "We couldn't find \(String(describing: type(of: itemType.self)))"
            guard let ids = ids, !ids.isEmpty else {
                return desc
            }
            return "\(desc) with ids: \(ids)"

        case let .invalidItemID(itemID, itemType):
            return "Invalid ItemID: Expected to decode \(itemType)# but found a \(itemID) instead."

        case let .invalidSummaryID(summaryID, itemType):
            return "Invalid SummaryID: Expected to decode \(itemType)# but found a \(summaryID) instead."

        case .handlerUnknown:
            return "Handler Unknown"
        }
    }

}
