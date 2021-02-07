//
//  GetRepositoryFactory.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 06/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import Foundation

enum GetRepositoryFactory {
    
    static func make(items: [String: Data] = [:]) -> GetRepository<MockComicInfoItem, TestCache<MockComicInfoItem>> {
        GetRepository(dataProvider: GetDataProviderFactory.make(items: items))
    }
    
}
