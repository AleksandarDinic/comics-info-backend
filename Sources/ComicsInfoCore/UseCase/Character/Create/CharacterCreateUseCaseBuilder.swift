//
//  CharacterCreateUseCaseBuilder.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 11/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation
import NIO

protocol CharacterCreateUseCaseBuilder {
    
    var eventLoop: EventLoop { get }
    
    func buildCharacterCreateUseCase() -> CharacterCreateUseCase
    
}

extension CharacterCreateUseCaseBuilder {
    
    func buildCharacterCreateUseCase() -> CharacterCreateUseCase {
        CharacterCreateUseCaseFactory(on: eventLoop, isLocalServer: LocalServer.isEnabled)
            .makeUseCase()
    }
    
}
