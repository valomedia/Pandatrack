//
//  XCTestCase+Screenshot.swift
//  ChronosUITests
//
//  Created by Jean-Pierre Höhmann on 2022-09-08.
//

import UIKit
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
    func addScreenshotAttachment(named name: String, from _: XCUIApplication) {
        let screenshot = XCUIScreen.main.screenshot()
        let pngData = screenshot.pngDataForCurrentOrientation
        let pixelSize = pngData.pngPixelSize
        let orientation = pixelSize.width > pixelSize.height ? "landscape" : "portrait"
        let attachment = XCTAttachment(data: pngData, uniformTypeIdentifier: "public.png")
        attachment.name = "\(name)-\(orientation)"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

}


// MARK: - Screenshot data

private extension XCUIScreenshot {

    // MARK: - Properties

    var pngDataForCurrentOrientation: Data {
        let pngData = pngRepresentation
        guard XCUIDevice.shared.orientation.isLandscape,
              let image = UIImage(data: pngData),
              let rotatedData = image.rotatedForLandscapeScreenshot.pngData()
        else { return pngData }

        return rotatedData
    }

}


// MARK: - Screenshot rotation

private extension UIImage {

    // MARK: - Properties

    var rotatedForLandscapeScreenshot: UIImage {
        let rotatedSize = CGSize(width: size.height, height: size.width)
        let renderer = UIGraphicsImageRenderer(size: rotatedSize)
        return renderer.image { context in
            let cgContext = context.cgContext
            cgContext.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
            cgContext.rotate(by: .pi / 2)
            draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        }
    }

}


// MARK: - PNG dimensions

private extension Data {

    // MARK: - Properties

    var pngPixelSize: (width: Int, height: Int) {
        let bytes = [UInt8](self)
        guard bytes.count >= 24 else { return (0, 0) }

        let width = (Int(bytes[16]) << 24) | (Int(bytes[17]) << 16) | (Int(bytes[18]) << 8) | Int(bytes[19])
        let height = (Int(bytes[20]) << 24) | (Int(bytes[21]) << 16) | (Int(bytes[22]) << 8) | Int(bytes[23])
        return (width, height)
    }

}
