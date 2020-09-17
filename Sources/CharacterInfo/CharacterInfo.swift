//
//  CharacterInfo.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 17/09/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import AWSLambdaRuntime
import Foundation

public final class CharacterInfo {

    static let characterCacheProvider = CharacterCacheProvider()

    static var isMocked: Bool {
        ProcessInfo.processInfo.environment["LOCAL_LAMBDA_SERVER_ENABLED"] == "true"
    }

    public init() {

    }

    public func runListLambda() {
        Lambda.run(CharacterListLambdaHandler.init)
    }

    public func runReadLambda() {
        Lambda.run(CharacterReadLambdaHandler.init)
    }

}
