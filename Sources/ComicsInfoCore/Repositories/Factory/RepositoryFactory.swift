//
//  RepositoryFactory.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 24/09/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public struct RepositoryFactory<APIWrapper: RepositoryAPIWrapper, CacheProvider: Cacheable>: DataProviderFactory where APIWrapper.Item == CacheProvider.Item {

    public let repositoryAPIWrapper: APIWrapper
    public let cacheProvider: CacheProvider
    public let decoderService: DecoderService
    public let encoderService: EncoderService

    public init(
        repositoryAPIWrapper: APIWrapper,
        cacheProvider: CacheProvider,
        decoderService: DecoderService = DecoderProvider(),
        encoderService: EncoderService = EncoderProvider()
    ) {
        self.repositoryAPIWrapper = repositoryAPIWrapper
        self.cacheProvider = cacheProvider
        self.decoderService = decoderService
        self.encoderService = encoderService
    }

    public func makeRepository() -> Repository<APIWrapper, CacheProvider> {
        Repository(dataProvider: makeDataProvider())
    }

}
