//
//  ReadResponseWrapper.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 24/09/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation
import NIO

public protocol ReadResponseWrapper: ErrorResponseWrapper {

    func handleRead(
        on eventLoop: EventLoop,
        request: Request,
        environment: String?
    ) -> EventLoopFuture<Response>

}

extension ReadResponseWrapper {
    
    func getFields(from pathParameters: [String: String]?) -> Set<String>? {
        guard let fields = pathParameters?["fields"]?.split(separator: ",").compactMap({ String($0) }) else {
            return nil
        }
        
        return Set(fields)
    }
    
}
