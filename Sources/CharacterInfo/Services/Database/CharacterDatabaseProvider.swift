//
//  CharacterDatabaseProvider.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 26/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import ComicsInfoCore
import Foundation
import NIO

final class CharacterDatabaseProvider: CharacterAPIService {

    private let database: Database
    private let tableName: String

    init(database: Database, tableName: String = DatabaseTable().name) {
        self.database = database
        self.tableName = tableName
    }

    func getAllCharacters(on eventLoop: EventLoop) -> EventLoopFuture<[[String: Any]]?> {
        database.getAll(fromTable: DatabaseTable().name)
    }

    func getCharacter(
        withID characterID: String,
        on eventLoop: EventLoop
    ) -> EventLoopFuture<[String: Any]?> {
        database.get(fromTable: DatabaseTable().name, forID: characterID)
    }

//    func createCharacter(_ character: Character) -> EventLoopFuture<Character> {
//    }
//
//    func updateCharacter(_ character: Character) -> EventLoopFuture<Character> {
//    }
//
//    func deleteCharacter(forID characterID: String) -> EventLoopFuture<Character> {
//    }

}
