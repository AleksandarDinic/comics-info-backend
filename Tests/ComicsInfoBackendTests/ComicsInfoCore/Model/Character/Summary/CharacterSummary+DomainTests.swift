//
//  CharacterSummary+DomainTests.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 05/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import struct Domain.ItemSummary
import XCTest

final class CharacterSummary_DomainTests: XCTestCase {

    private var item: Domain.ItemSummary!
    private var series: Series!
    private var count: Int!
    private var sut: CharacterSummary!
    
    override func setUpWithError() throws {
        item = DomainItemSummaryFactory.make()
        series = SeriesFactory.make(ID: "SeriesID")
        count = 0
        sut = CharacterSummary(from: item, link: series, count: count)
    }

    override func tearDownWithError() throws {
        item = nil
        series = nil
        count = nil
        sut = nil
    }

    func testItemID_whenInitFromItem() throws {
        XCTAssertEqual(sut.itemID, "\(String.getType(from: Character.self))#\(item.identifier)")
    }
    
    func testSummaryID_whenInitFromItem() {
        XCTAssertEqual(sut.summaryID, "\(String.getType(from: Series.self))#\(series.id)")
    }
    
    func testItemName_whenInitFromItem() {
        XCTAssertEqual(sut.itemName, .getType(from: CharacterSummary.self))
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
    
    func testCount_whenInitFromItem() {
        XCTAssertEqual(sut.count, count)
    }

}
