//
//  Comic.swift
//  ComicsInfoCore
//
//  Created by Aleksandar Dinic on 04/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public struct Comic: ComicsInfoItem {

    /// The unique ID of the comic resource.
    public let id: String

    /// The value of comic popularity.
    let popularity: Int

    /// The canonical title of the comic.
    let title: String
    
    /// Date the comic was added to Comic Info.
    let dateAdded: Date
    
    /// Date the comic was last updated on Comic Info.
    let dateLastUpdated: Date

    /// The representative image for this comics.
    let thumbnail: String?

    /// The preferred description of the comic.
    let description: String?

    /// The number of the issue in the series.
    let issueNumber: String?

    /// If the issue is a variant (e.g. an alternate cover, second printing, or director’s cut),
    /// a text description of the variant.
    let variantDescription: String?

    /// The publication format of the comic e.g. comic, hardcover, trade paperback.
    let format: String?

    /// The Int of story pages in the comic.
    let pageCount: Int?

    /// A list of variant issues ID for this comic (includes the "original" issue if the current
    /// issue is a variant).
    let variantsIdentifier: [String]?

    /// A list of collections ID which include this comic (will generally be nil if the comic's
    /// format is a collection).
    let collectionsIdentifier: [String]?

    /// A list of issues ID collected in this comic (will generally be nil for periodical formats
    /// such as "comic" or "magazine").
    let collectedIssuesIdentifier: [String]?

    /// A list of promotional images associated with this comic.
    let images: [String]?

    /// The date of publication for this comic.
    let published: Date?

    /// A resource list containing charactersID which appear in this comic.
    var charactersID: Set<String>?

    /// A resource list containing the characters which appear in this comic.
    let characters: [Character]?

    /// A resource list of seriesID in which this comic appears.
    var seriesID: Set<String>?

    /// A resource list containing the series in which this comic appears.
    let series: [Series]?

    mutating func removeID(_ itemID: String) {
        if itemID.starts(with: String.getType(from: Character.self)) {
            let id = itemID.dropFirst("\(String.getType(from: Character.self))#".count)
            charactersID?.remove(String(id))
        } else if itemID.starts(with: String.getType(from: Series.self)) {
            let id = itemID.dropFirst("\(String.getType(from: Series.self))#".count)
            seriesID?.remove(String(id))
        }
    }

}

extension Comic {
    
    enum CodingKeys: String, CodingKey {
        case id
        case popularity
        case title
        case thumbnail
        case description
        case issueNumber
        case variantDescription
        case format
        case pageCount
        case variantsIdentifier
        case collectionsIdentifier
        case collectedIssuesIdentifier
        case images
        case published
        case charactersID
        case characters
        case seriesID
        case series
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        popularity = try values.decode(Int.self, forKey: .popularity)
        title = try values.decode(String.self, forKey: .title)
        dateAdded = Date()
        dateLastUpdated = Date()
        thumbnail = try? values.decode(String.self, forKey: .thumbnail)
        description = try? values.decode(String.self, forKey: .description)
        issueNumber = try? values.decode(String.self, forKey: .issueNumber)
        variantDescription = try? values.decode(String.self, forKey: .variantDescription)
        format = try? values.decode(String.self, forKey: .format)
        pageCount = try? values.decode(Int.self, forKey: .pageCount)
        variantsIdentifier = try? values.decode([String].self, forKey: .variantsIdentifier)
        collectionsIdentifier = try? values.decode([String].self, forKey: .collectionsIdentifier)
        collectedIssuesIdentifier = try? values.decode([String].self, forKey: .collectedIssuesIdentifier)
        images = try? values.decode([String].self, forKey: .images)
        published = try? values.decode(Date.self, forKey: .published)
        charactersID = try? values.decode(Set<String>.self, forKey: .charactersID)
        characters = try? values.decode([Character].self, forKey: .characters)
        seriesID = try? values.decode(Set<String>.self, forKey: .seriesID)
        series = try? values.decode([Series].self, forKey: .series)
    }
    
}
