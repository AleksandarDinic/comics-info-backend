//
//  Lambda+EnvironmentTests.swift
//  ComicsInfoBackendTests
//
//  Created by Aleksandar Dinic on 07/10/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfoCore
import enum AWSLambdaRuntime.Lambda
import XCTest

final class Lambda_EnvironmentTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_region_isNil() {
        XCTAssertNil(Lambda.region)
    }

    func test_handler_isEmptyString() {
        XCTAssertEqual(Lambda.handler, "")
    }

    func test_tableName_() {
        XCTAssertEqual(Lambda.tableName(for: "TEST"), "TABLE_NAME_TEST")
    }

}
