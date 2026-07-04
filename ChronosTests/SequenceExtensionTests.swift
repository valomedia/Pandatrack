//
//  SequenceExtensionTests.swift
//  ChronosTests
//
//  Created by Jean-Pierre Höhmann on 2022-09-08.
//

import Foundation
import XCTest

@testable
import Chronos


// MARK: - SequenceExtensionTests

final class SequenceExtensionTests: XCTestCase {

    func testSumAddsNumericSequences() {
        XCTAssertEqual([1, 2, 3, 4].sum(), 10)
        XCTAssertEqual([Int]().sum(), 0)
    }

    func testSortedByKeyPathOrdersElements() {
        let entries = [
            TestEntry(name: "later", seconds: 120),
            TestEntry(name: "earlier", seconds: 30),
            TestEntry(name: "middle", seconds: 60),
        ]

        XCTAssertEqual(entries.sorted(by: \.seconds).map(\.name), ["earlier", "middle", "later"])
    }

    func testReduceWithoutInitialValueUsesPreviousPartialResult() {
        let result = ["build", "test", "ship"].reduce { partialResult, word in
            partialResult.map { "\($0), \(word)" } ?? word
        }

        XCTAssertEqual(result, "build, test, ship")
    }

}


// MARK: - TestEntry

private struct TestEntry {
    let name: String
    let seconds: Int
}
