//
//  XCTestCase+Screenshot.swift
//  ChronosUITests
//
//  Created by Jean-Pierre Höhmann on 2022-09-08.
//

import XCTest


// MARK: - Screenshot attachments

extension XCTestCase {

    // MARK: - Methods

    /// Add a screenshot attachment that is retained in the test result bundle.
    ///
    /// - Parameters:
    ///   - name: The base slug for the attachment name shown in the test result bundle.
    ///   - app: The application to capture.
    ///
    func addScreenshotAttachment(named name: String, from app: XCUIApplication) {
        let screenshot = app.screenshot()
        let orientation = screenshot.image.size.width > screenshot.image.size.height ? "landscape" : "portrait"
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "\(name)-\(orientation)"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

}
