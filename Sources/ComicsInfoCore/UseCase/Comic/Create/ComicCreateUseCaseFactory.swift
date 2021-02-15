//
//  ComicCreateUseCaseFactory.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 08/01/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation
import NIO

public struct ComicCreateUseCaseFactory: CreateUseCaseFactory, UpdateRepositoryBuilder, ComicUpdateUseCaseBuilder, CharacterUseCaseBuilder, SeriesUseCaseBuilder, ComicUseCaseBuilder {

    public let eventLoop: EventLoop
    public let isLocalServer: Bool

    public init(on eventLoop: EventLoop, isLocalServer: Bool) {
        self.eventLoop = eventLoop
        self.isLocalServer = isLocalServer
    }

    public func makeUseCase() -> ComicCreateUseCase {
        ComicCreateUseCase(
            createRepository: makeCreateRepository(),
            updateRepository: makeUpdateRepository(),
            characterUseCase: buildCharacterUseCase(),
            seriesUseCase: buildSeriesUseCase(),
            comicUseCase: buildComicUseCase()
        )
    }

}
