//
//  ChronosUITestsLaunchTests.swift
//  ChronosUITests
//
//  Created by Jean-Pierre Höhmann on 2022-09-08.
//

import Foundation
import XCTest


// MARK: ChronosUITestsLaunchTests

/// UI launch tests for Chronos
///
/// Heavy test suite run before submitting a new version of the app to the App Store.
///
class ChronosUITestsLaunchTests: XCTestCase {

    // MARK: - Static properties

    /// Rerun for each supported UI configuration.
    ///
    /// This causes the UI tests to run once for each possible combination of orientation, localization, and other
    /// appearance settings the app supports.
    ///
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    // MARK: - Life cycle methods

    /// Setup code.
    ///
    /// This method is called before the invocation of each test method in the class.
    ///
    /// - Throws:
    ///
    override func setUpWithError() throws {
        // Stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    /// Teardown code.
    ///
    /// This method is called after the invocation of each test method in the class.
    ///
    /// - Throws:
    ///
    override func tearDownWithError() throws {}


    // MARK: - Tests

    /// Take a screenshot.
    ///
    /// This will launch the application and take a screenshot of the initial screen displayed after launch.
    ///
    /// - Throws:
    ///
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
