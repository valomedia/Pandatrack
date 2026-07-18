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
    func addScreenshotAttachment(named name: String, from app: XCUIApplication) {
        let screenshot = XCUIScreen.main.screenshot()
        let pngData = screenshot.pngDataForCurrentOrientation
        let pixelSize = pngData.pngPixelSize
        let orientation = pixelSize.width > pixelSize.height ? "landscape" : "portrait"
        let configuration = app.targetApplicationUIConfigurationScreenshotNameComponent
        let attachment = XCTAttachment(data: pngData, uniformTypeIdentifier: "public.png")
        attachment.name = "\(name)-\(configuration)-\(orientation)"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

}


// MARK: - Target application UI configuration

private extension XCUIApplication {

    // MARK: - Properties

    var targetApplicationUIConfigurationScreenshotNameComponent: String {
        let traits = UIScreen.main.traitCollection
        return [
            "style-\(traits.userInterfaceStyle.screenshotNameComponent)",
            "content-size-\(contentSizeCategoryScreenshotNameComponent(from: traits))",
            "languages-\(languagesScreenshotNameComponent)",
            "locale-\(localeScreenshotNameComponent)"
        ].joined(separator: "-")
    }

    private var languagesScreenshotNameComponent: String {
        launchArgumentValue(after: "-AppleLanguages")?.screenshotNameComponent
                ?? Locale.preferredLanguages.joined(separator: ",").screenshotNameComponent
    }

    private var localeScreenshotNameComponent: String {
        launchArgumentValue(after: "-AppleLocale")?.screenshotNameComponent
                ?? Locale.current.identifier.screenshotNameComponent
    }

    // MARK: - Methods

    private func contentSizeCategoryScreenshotNameComponent(from traits: UITraitCollection) -> String {
        launchArgumentValue(after: "-UIPreferredContentSizeCategoryName")?.screenshotNameComponent
                ?? traits.preferredContentSizeCategory.rawValue.screenshotNameComponent
    }

    private func launchArgumentValue(after option: String) -> String? {
        guard let optionIndex = launchArguments.firstIndex(of: option) else { return nil }

        let valueIndex = launchArguments.index(after: optionIndex)
        guard valueIndex < launchArguments.endIndex else { return nil }

        return launchArguments[valueIndex]
    }

}


// MARK: - Interface style names

private extension UIUserInterfaceStyle {

    // MARK: - Properties

    var screenshotNameComponent: String {
        switch self {
        case .unspecified:
            return "unspecified"
        case .light:
            return "light"
        case .dark:
            return "dark"
        @unknown default:
            return "unknown-\(rawValue)"
        }
    }

}


// MARK: - Screenshot name components

private extension String {

    // MARK: - Properties

    var screenshotNameComponent: String {
        let components = lowercased()
                .split { !$0.isLetter && !$0.isNumber }
                .map(String.init)
        guard !components.isEmpty else { return "unspecified" }

        return components.joined(separator: "-")
    }

}


// MARK: - Screenshot data

private extension XCUIScreenshot {

    // MARK: - Properties

    var pngDataForCurrentOrientation: Data {
        let pngData = pngRepresentation
        guard XCUIDevice.shared.orientation.isLandscape,
              let rotatedData = UIImage(data: pngData)?.landscapeScreenshotPNGData
        else { return pngData }

        return rotatedData
    }

}


// MARK: - Screenshot rotation

private extension UIImage {

    // MARK: - Properties

    var landscapeScreenshotPNGData: Data? {
        guard let cgImage else { return nil }

        let imageSize = CGSize(width: cgImage.width, height: cgImage.height)
        let rotatedSize = CGSize(width: imageSize.height, height: imageSize.width)
        let rendererFormat = UIGraphicsImageRendererFormat()
        rendererFormat.scale = 1
        let renderer = UIGraphicsImageRenderer(size: rotatedSize, format: rendererFormat)
        let drawRect = CGRect(
                x: -imageSize.width / 2,
                y: -imageSize.height / 2,
                width: imageSize.width,
                height: imageSize.height
        )
        return renderer.image { context in
            let cgContext = context.cgContext
            cgContext.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
            cgContext.rotate(by: .pi / 2)
            UIImage(cgImage: cgImage).draw(in: drawRect)
        }.pngData()
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
