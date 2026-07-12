//
//  BoolExtensionTests.swift
//  ChronosTests
//

import Foundation
import XCTest

@testable
import Chronos


// MARK: - BoolExtensionTests

final class BoolExtensionTests: XCTestCase {

    func testThenReturnsValueOnlyWhenConditionIsTrue() {
        XCTAssertEqual(true.then("value"), "value")
        XCTAssertNil(false.then("value"))
    }

    func testElseReturnsValueOnlyWhenConditionIsFalse() {
        XCTAssertNil(true.`else`("fallback"))
        XCTAssertEqual(false.`else`("fallback"), "fallback")
    }

    func testThenOperatorMatchesThenMethod() {
        XCTAssertEqual(true .!! "value", true.then("value"))
        XCTAssertNil(false .!! "value")
    }

}
