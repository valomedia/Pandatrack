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
        let screenshot = app.screenshot()
        let slug = ScreenshotAttachmentNames.nextSlug(from: [
            String(describing: type(of: self)),
            self.name,
            name,
        ])
        let screenshotsDirectory = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
                .appendingPathComponent("PandatrackUITestScreenshots", isDirectory: true)
        let fileURL = screenshotsDirectory.appendingPathComponent("\(slug).png")

        do {
            try FileManager.default.createDirectory(at: screenshotsDirectory, withIntermediateDirectories: true)
            try screenshot.pngRepresentation.write(to: fileURL, options: .atomic)
        } catch {
            XCTFail("Failed to write screenshot attachment '\(slug)': \(error)")
            return
        }

        let attachment = XCTAttachment(contentsOfFile: fileURL)
        attachment.name = slug
        attachment.lifetime = .keepAlways
        add(attachment)
    }

}


// MARK: - Screenshot attachment names

private enum ScreenshotAttachmentNames {

    // MARK: - Static properties

    private static let lock = NSLock()
    private static var counts: [String: Int] = [:]

    // MARK: - Static methods

    static func nextSlug(from components: [String]) -> String {
        let baseSlug = components.joined(separator: "-").slugified()

        lock.lock()
        defer { lock.unlock() }

        let count = (counts[baseSlug] ?? 0) + 1
        counts[baseSlug] = count

        if count == 1 { return baseSlug }
        return "\(baseSlug)-\(count)"
    }

}


// MARK: - String slugification

private extension String {

    // MARK: - Methods

    func slugified() -> String {
        let allowedCharacters = CharacterSet.alphanumerics
        var slug = ""
        var lastCharacterWasDash = false

        for scalar in lowercased().unicodeScalars {
            if allowedCharacters.contains(scalar) {
                slug.append(Character(scalar))
                lastCharacterWasDash = false
            } else if !lastCharacterWasDash {
                slug.append("-")
                lastCharacterWasDash = true
            }
        }

        return slug.trimmingCharacters(in: CharacterSet(charactersIn: "-"))
    }

}
