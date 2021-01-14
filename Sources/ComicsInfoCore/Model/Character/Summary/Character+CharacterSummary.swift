//
//  Character+CharacterSummary.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 29/09/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

extension Character {

    init(fromSummary character: CharacterSummary) {
        self.init(
            id: character.id,
            popularity: character.popularity,
            name: character.name,
            dateAdded: character.dateAdded,
            dateLastUpdated: character.dateLastUpdated,
            thumbnail: character.thumbnail,
            description: character.description,
            realName: nil,
            aliases: nil,
            birth: nil,
            seriesID: nil,
            series: nil,
            comicsID: nil,
            comics: nil
        )
    }

}
