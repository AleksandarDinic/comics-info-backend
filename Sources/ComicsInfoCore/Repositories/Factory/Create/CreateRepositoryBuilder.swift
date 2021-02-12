//
//  CreateRepositoryBuilder.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 11/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Logging
import Foundation
import NIO

public protocol CreateRepositoryBuilder  {

    var eventLoop: EventLoop { get }
    var isLocalServer: Bool { get }
    var logger: Logger { get }
    
    func makeCreateRepository() -> CreateRepository

}

extension CreateRepositoryBuilder {
    
    public func makeCreateRepository() -> CreateRepository {
        CreateRepositoryFactory(itemCreateDBService: makeItemCreateDBService())
            .make()
    }

    private func makeItemCreateDBService() -> ItemCreateDBService {
        CreateDatabaseProvider(database: makeDatabase())
    }

    private func makeDatabase() -> DatabaseCreate {
        DatabaseFectory(isLocalServer: isLocalServer)
            .makeDatabaseCreate(eventLoop: eventLoop, logger: logger)
    }

}
