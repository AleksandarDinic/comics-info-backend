//
//  Request.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 10/09/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public struct Request: Codable {

    public let pathParameters: [String: String]?
    public let context: Context

}

extension Request {

    enum CodingKeys: String, CodingKey {
        case pathParameters
        case context = "requestContext"
    }

}
