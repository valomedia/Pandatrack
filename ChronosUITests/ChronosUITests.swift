//
//  ChronosUITests.swift
//  ChronosUITests
//
//  Created by Jean-Pierre Höhmann on 2022-09-08.
//

import Foundation
import XCTest


// MARK: ChronosUITests

/// General UI tests for Chronos.
///
class ChronosUITests: XCTestCase {

    // MARK: - Static properties

    private static let entryName = "Instrumented test entry"

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

    /// Create a new time entry through the real application UI.
    ///
    /// - Throws:
    ///
    func testCreatesTimeEntry() throws {
        let app = makeApp(resetPersistentStore: true)
        app.launch()

        XCTAssertTrue(app.navigationBars["Time Entries"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Hi, I‘m Pandy!"].exists)

        app.buttons["Add"].tap()

        let nameField = app.textFields["Name"]
        XCTAssertTrue(nameField.waitForExistence(timeout: 5))
        nameField.tap()
        nameField.typeText(Self.entryName)

        app.buttons["Done"].tap()

        let entry = app.descendants(matching: .any)
                .matching(NSPredicate(format: "label == 'Entry' AND value == %@", Self.entryName))
                .firstMatch
        XCTAssertTrue(entry.waitForExistence(timeout: 5))

        addScreenshotAttachment(named: "Created Time Entry", from: app)
    }

    /// Show the add-entry form through the real application UI.
    ///
    /// - Throws:
    ///
    func testShowsAddEntryForm() throws {
        let app = makeApp(resetPersistentStore: true)
        app.launch()

        XCTAssertTrue(app.navigationBars["Time Entries"].waitForExistence(timeout: 5))
        app.buttons["Add"].tap()

        XCTAssertTrue(app.textFields["Name"].waitForExistence(timeout: 5))
        addScreenshotAttachment(named: "Add Time Entry Form", from: app)
    }

    /// Measure how long it takes to launch the application.
    ///
    /// - Throws:
    ///
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            makeApp(resetPersistentStore: true).launch()
        }
    }

    // MARK: - Methods

    private func makeApp(resetPersistentStore: Bool) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments.append("--ui-testing")
        if resetPersistentStore { app.launchArguments.append("--reset-persistent-store") }
        return app
    }

}


// MARK: - Screenshot attachments

extension XCTestCase {

    // MARK: - Methods

    /// Add a screenshot attachment that is retained in the test result bundle.
    ///
    /// - Parameters:
    ///   - name: The attachment name shown in the test result bundle.
    ///   - app: The application to capture.
    ///
    func addScreenshotAttachment(named name: String, from app: XCUIApplication) {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

}
