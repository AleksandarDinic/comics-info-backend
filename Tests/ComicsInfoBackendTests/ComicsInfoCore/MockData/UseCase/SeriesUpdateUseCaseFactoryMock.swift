//
//  SeriesUpdateUseCaseFactoryMock.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 11/01/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import Foundation
import Logging
import NIO

struct SeriesUpdateUseCaseFactoryMock: UpdateUseCaseFactory {

    let eventLoop: EventLoop
    let logger: Logger

    let isLocalServer: Bool

    init(on eventLoop: EventLoop? = nil, logger: Logger? = nil) {
        self.eventLoop = eventLoop ?? MultiThreadedEventLoopGroup(numberOfThreads: 1).next()
        self.logger = logger ?? Logger(label: "SeriesUseCaseFactoryMock")
        isLocalServer = true
    }

    func makeUseCase() -> SeriesUpdateUseCase {
        SeriesUpdateUseCase(
            repository: makeRepository(),
            characterUseCase: CharacterUseCaseFactoryMock().makeUseCase(),
            seriesUseCase: SeriesUseCaseFactoryMock().makeUseCase(),
            comicUseCase: ComicUseCaseFactoryMock().makeUseCase()
        )
    }

    private func makeRepository() -> UpdateRepository {
        ComicsInfoCore.UpdateRepositoryFactory(itemUpdateDBService: makeItemUpdateDBService())
            .make()
    }
    
    func makeItemUpdateDBService() -> ItemUpdateDBService {
        UpdateDatabaseProvider(database: makeDatabase())
    }

    private func makeDatabase() -> DatabaseUpdate {
        DatabaseFectory(isLocalServer: isLocalServer)
            .makeDatabaseUpdate(eventLoop: eventLoop, logger: logger)
    }
    
}
