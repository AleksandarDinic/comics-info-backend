//
//  UpdateDataProviderFactory.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 07/01/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol UpdateDataProviderFactory: ItemUpdateDBWrapperFactory {

    func makeDataProvider() -> UpdateDataProvider

}

extension UpdateDataProviderFactory {

    func makeDataProvider() -> UpdateDataProvider {
        UpdateDataProvider(itemUpdateDBWrapper: makeItemUpdateDBWrapper())
    }

}
