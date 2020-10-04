//
//  CharacterGetAllMetadataAPIWrapper.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 04/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct CharacterGetAllMetadataAPIWrapper: GetAllMetadataAPIWrapper {

    typealias Item = Character

    let repositoryAPIService: RepositoryAPIService
    let decoderService: DecoderService

}
