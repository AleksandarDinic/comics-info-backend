//
//  GetQueryParameterSeriesID.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 14/03/2021.
//

import Foundation

protocol GetQueryParameterSeriesID {
    
    func getSeriesID(from queryParameters: [String: String]?) throws -> String
    
}

extension GetQueryParameterSeriesID {
    
    func getSeriesID(from queryParameters: [String: String]?) throws -> String {
        guard let seriesID = queryParameters?["seriesID"] else {
            throw ComicInfoError.queryParameterSeriesIDIsMissing
        }
        
        return seriesID
    }
    
}
