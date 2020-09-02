//
//  CharacterDataProviderMockFactory.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 02/09/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import Foundation

struct CharacterDataProviderMockFactory {

    static func makeWithCharactersFromDatabase() -> CharacterDataProvider {
        let characterAPIWrapper = CharacterAPIWrapperMockFactory.makeWithCharacters()
        let characterCacheService = CharacterCacheServiceMock()

        return CharacterDataProvider(
            characterAPIWrapper: characterAPIWrapper,
            characterCacheService: characterCacheService
        )
    }

    static func makeWithCharactersFromMemory() -> CharacterDataProvider {
        let characterAPIWrapper = CharacterAPIWrapperMockFactory.makeWithoutData()
        let characterCacheService = CharacterCacheServiceMock()
        characterCacheService.setCharacters(CharactersMock.characters)

        return CharacterDataProvider(
            characterAPIWrapper: characterAPIWrapper,
            characterCacheService: characterCacheService
        )
    }

    static func makeWithoutData() -> CharacterDataProvider {
        let characterAPIWrapper = CharacterAPIWrapperMockFactory.makeWithoutData()
        let characterCacheService = CharacterCacheServiceMock()

        return CharacterDataProvider(
            characterAPIWrapper: characterAPIWrapper,
            characterCacheService: characterCacheService
        )
    }

    static func makeWithCharacterFromDatabase() -> CharacterDataProvider {
        let characterAPIWrapper = CharacterAPIWrapperMockFactory.makeWithCharacter()
        let characterCacheService = CharacterCacheServiceMock()

        return CharacterDataProvider(
            characterAPIWrapper: characterAPIWrapper,
            characterCacheService: characterCacheService
        )
    }

    static func makeWithCharacterFromMemory() -> CharacterDataProvider {
        let characterAPIWrapper = CharacterAPIWrapperMockFactory.makeWithoutData()
        let characterCacheService = CharacterCacheServiceMock()
        characterCacheService.setCharacter(CharactersMock.character)

        return CharacterDataProvider(
            characterAPIWrapper: characterAPIWrapper,
            characterCacheService: characterCacheService
        )
    }

}
