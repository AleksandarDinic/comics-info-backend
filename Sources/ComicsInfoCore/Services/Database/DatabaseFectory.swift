//
//  DatabaseFectory.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 28/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct AWSDynamoDB.DynamoDB
import Foundation
import NIO

public struct DatabaseFectory {

    private let mocked: Bool

    public init(mocked: Bool) {
        self.mocked = mocked
    }

    public func makeDatabase(eventLoop: EventLoop) -> Database {
        guard !mocked else {
            return DatabaseMock(eventLoop: eventLoop)
        }

        return AWSDynamoDB.DynamoDB(eventLoop: eventLoop)
    }

}
