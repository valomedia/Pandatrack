# AGENTS.md – Pandatrack

## Project
- Pandatrack is an iOS time-tracking app.
- The Xcode project is `Chronos.xcodeproj`; the app target is `Chronos (iOS)`.
- Source is Swift/SwiftUI with Core Data and a SwiftGen build phase.

## Commands
- `open Chronos.xcodeproj` - open the app in Xcode for local development.
- `xcodebuild -project Chronos.xcodeproj -scheme "Chronos (iOS)" -destination 'platform=iOS Simulator,name=<installed simulator>' build` - build the app on macOS with Xcode.
- `xcodebuild -project Chronos.xcodeproj -scheme "Chronos (iOS)" -destination 'platform=iOS Simulator,name=<installed simulator>' test` - run unit and UI tests on macOS with Xcode.
- `SRCROOT="$PWD" Chronos/swiftgen.sh` - regenerate SwiftGen outputs when SwiftGen is installed.

## Structure
- `Chronos/ChronosApp.swift` - SwiftUI app entry point.
- `Chronos/Controllers/` - app services such as persistence, timers, previews, and popup controllers.
- `Chronos/Models/` - Core Data model classes, domain types, builders, themes, and generated SwiftGen outputs.
- `Chronos/Views/` - SwiftUI screens, tabs, charts, controls, and view modifiers.
- `Chronos/Chronos.xcdatamodeld/` - Core Data schema.
- `Chronos/Assets.xcassets/` - colors, app icons, theme colors, and images.
- `Chronos/Resources/*.lproj/Localizable.strings` - localized strings.
- `Chronos/Settings.bundle/` - iOS Settings bundle.
- `Chronos/Templates/` and `Chronos/swiftgen.yml` - SwiftGen Stencil templates and generation config.
- `ChronosTests/` and `ChronosUITests/` - XCTest targets.

## Dependencies and generation
- Xcode resolves Swift Package dependencies from `Chronos.xcodeproj`:
  `observed-optional-object` and Apple `swift-collections`.
- The app target has a `Run swiftgen` build phase that executes `Chronos/swiftgen.sh`.
- SwiftGen outputs are `Chronos/Models/Assets+Generated.swift`,
  `Chronos/Models/CoreData+Generated.swift`,
  `Chronos/Models/Settings+Generated.swift`, and
  `Chronos/Models/Strings+Generated.swift`.
- `*+Generated.swift` files are ignored by git;
  update SwiftGen inputs, templates, or config instead of hand-editing generated output.

## Working rules
- Follow the existing Swift style:
  file header comments, `// MARK:` sections, and small focused extensions or views.
- Keep changes to `Chronos.xcodeproj/project.pbxproj` and `Chronos/Chronos.xcdatamodeld/` minimal,
  because Xcode-owned files are noisy and easy to corrupt.
- When adding assets, localized strings, settings, or Core Data fields,
  update the matching SwiftGen file lists/config and regenerate outputs locally before relying on generated APIs.
- Debug simulator builds use preview/sample paths in `ChronosApp` and `PersistenceController.preview`;
  do not assume those code paths run in release or on device.

## Verification
- Prefer an Xcode build or test run on macOS before reporting app changes.
- If working in a non-macOS environment,
  document that Xcode verification was unavailable and at least inspect the relevant Swift/Xcode project diff.
