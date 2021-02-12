//
//  CreateUseCaseFactory.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 08/01/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol CreateUseCaseFactory: CreateRepositoryBuilder  {

    associatedtype UseCaseType: CreateUseCase

    func makeUseCase() -> UseCaseType

}
