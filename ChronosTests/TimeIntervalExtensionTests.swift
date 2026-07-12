//
//  TimeIntervalExtensionTests.swift
//  ChronosTests
//

import Foundation
import XCTest

@testable
import Chronos


// MARK: - TimeIntervalExtensionTests

final class TimeIntervalExtensionTests: XCTestCase {

    func testTimeIntervalConversionsUseSeconds() {
        let interval: TimeInterval = 7_200

        XCTAssertEqual(interval.minutes, 120)
        XCTAssertEqual(interval.hours, 2)
    }

}
