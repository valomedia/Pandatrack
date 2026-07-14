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
        let orientation = screenshot.pngPixelSize.width > screenshot.pngPixelSize.height ? "landscape" : "portrait"
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "\(name)-\(orientation)"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

}


// MARK: - Screenshot dimensions

private extension XCUIScreenshot {

    // MARK: - Properties

    var pngPixelSize: (width: Int, height: Int) {
        let bytes = [UInt8](pngRepresentation)
        guard bytes.count >= 24 else { return (Int(image.size.width), Int(image.size.height)) }

        let width = (Int(bytes[16]) << 24) | (Int(bytes[17]) << 16) | (Int(bytes[18]) << 8) | Int(bytes[19])
        let height = (Int(bytes[20]) << 24) | (Int(bytes[21]) << 16) | (Int(bytes[22]) << 8) | Int(bytes[23])
        return (width, height)
    }

}
