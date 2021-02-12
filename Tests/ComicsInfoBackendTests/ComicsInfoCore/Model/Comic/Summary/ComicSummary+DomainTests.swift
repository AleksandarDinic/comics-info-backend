//
//  ComicSummary+DomainTests.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 05/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import struct Domain.ItemSummary
import XCTest

final class ComicSummary_DomainTests: XCTestCase {

    private var item: Domain.ItemSummary!
    private var series: Series!
    private var number: String!
    private var sut: ComicSummary!
    
    override func setUpWithError() throws {
        item = DomainItemSummaryFactory.make()
        series = SeriesFactory.make(ID: "SeriesID")
        number = "1"
        sut = ComicSummary(from: item, link: series, number: number)
    }

    override func tearDownWithError() throws {
        item = nil
        series = nil
        number = nil
        sut = nil
    }
    
    func testItemID_whenInitFromItem() throws {
        XCTAssertEqual(sut.itemID, "\(String.getType(from: Comic.self))#\(item.identifier)")
    }
    
    func testSummaryID_whenInitFromItem() {
        XCTAssertEqual(sut.summaryID, "\(String.getType(from: Series.self))#\(series.id)")
    }
    
    func testItemType_whenInitFromItem() {
        XCTAssertEqual(sut.itemType, .getType(from: ComicSummary.self))
    }
    
    func testDateAdded_whenInitFromItem() {
        XCTAssertEqual(
            Calendar.current.compare(sut.dateAdded, to: Date(), toGranularity: .hour),
            .orderedSame
        )
    }
    
    func testDateLastUpdated_whenInitFromItem() {
        XCTAssertEqual(
            Calendar.current.compare(sut.dateLastUpdated, to: Date(), toGranularity: .hour),
            .orderedSame
        )
    }
    
    func testPopularity_whenInitFromItem() {
        XCTAssertEqual(sut.popularity, item.popularity)
    }
    
    func testName_whenInitFromItem() {
        XCTAssertEqual(sut.name, item.name)
    }
    
    func testThumbnail_whenInitFromItem() {
        XCTAssertEqual(sut.thumbnail, item.thumbnail)
    }
    
    func testDescription_whenInitFromItem() {
        XCTAssertEqual(sut.description, item.description)
    }
    
    func testNumber_whenInitFromItem() {
        XCTAssertEqual(sut.number, number)
    }

}
