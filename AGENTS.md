# AGENTS.md

## Project Overview

Pandatrack is an iOS time-tracking app.
The Xcode project is `Chronos.xcodeproj`.
The app target is `Chronos (iOS)`,
with unit tests in `ChronosTests` and UI tests in `ChronosUITests`.

Most source code lives under `Chronos/`.
The project uses SwiftUI for views,
Core Data for persistence,
Swift Package Manager dependencies declared in the Xcode project,
and SwiftGen templates under `Chronos/Templates/` for generated resource helpers.

## Repository Layout

- `Chronos/` contains the application source,
  resources,
  Core Data model,
  SwiftGen configuration,
  and SwiftGen templates.
- `Chronos/Controllers/` contains persistence,
  timer,
  environment,
  and popup controller code.
- `Chronos/Models/` contains app models,
  Core Data classes,
  generated-helper targets,
  and value types.
- `Chronos/Views/` contains SwiftUI views and view modifiers.
- `Chronos/Extensions/` contains small focused Swift extensions.
- `ChronosTests/` and `ChronosUITests/` contain XCTest targets.
- `Chronos.xcodeproj/` is the source of truth for targets,
  build settings,
  and Swift Package dependencies.

## Commands

This repository has no `Package.swift`
and no separate command-line build system.
Use Xcode or `xcodebuild` against `Chronos.xcodeproj`.
No shared schemes are tracked,
so inspect available schemes and targets before running a build command.

Useful checks when Xcode command-line tools are available:

```sh
xcodebuild -list -project Chronos.xcodeproj
xcodebuild -project Chronos.xcodeproj -scheme "<scheme from xcodebuild -list>" -destination 'platform=iOS Simulator,name=iPhone 15' build
xcodebuild -project Chronos.xcodeproj -scheme "<scheme from xcodebuild -list>" -destination 'platform=iOS Simulator,name=iPhone 15' test
```

If a named simulator is unavailable,
list installed devices with:

```sh
xcrun simctl list devices available
```

Some Linux-based automation environments do not include `xcodebuild`.
When that is the case,
verify changes with direct inspection and repository-local checks,
and state that full Xcode build or test verification was unavailable.

## Swift and Xcode Guidance

Match the existing Swift style.
Use the file header and `// MARK:` structure already present in nearby files.
Group imports at the top of each file,
then leave the same blank-line spacing style used by the surrounding code.
Prefer small focused extensions and view files over large mixed-purpose files.

Keep SwiftUI view changes in `Chronos/Views/` unless the change is clearly model or controller logic.
Keep persistence changes close to the Core Data model and related `NSManagedObject` subclasses.
When changing Core Data entities,
update both the `.xcdatamodeld` model and any handwritten model helpers that depend on it.

The project currently targets Swift 5 through Xcode build settings.
Do not introduce language features or package requirements that would require changing the Swift version or deployment target unless the issue explicitly asks for that.

## Generated Files and Assets

`Chronos/swiftgen.yml` configures SwiftGen for localized strings,
asset catalogs,
Core Data helpers,
and settings helpers.
The script `Chronos/swiftgen.sh` runs SwiftGen from the app source root.

Files matching `*+Generated.swift` are ignored by Git.
Do not hand-edit generated Swift files.
Change the source asset catalog,
localized strings,
Core Data model,
settings bundle,
or templates instead,
then regenerate with SwiftGen in an Xcode-capable environment.

Keep app icons,
colors,
and image sets inside `Chronos/Assets.xcassets/`.
Avoid renaming asset catalog entries without updating all typed references and SwiftGen inputs.

## Dependencies

Swift Package dependencies are declared in `Chronos.xcodeproj/project.pbxproj`.
Current package references include `swift-collections` and `observed-optional-object`.
Do not vendor package checkouts or generated dependency caches into the repository.
Let Xcode resolve packages into local derived data or user-specific caches.

## Testing Guidance

Add or update XCTest coverage in `ChronosTests/` for model,
date,
formatting,
and controller logic when practical.
Use `ChronosUITests/` for end-to-end UI behavior only.
Keep tests deterministic and avoid relying on wall-clock time unless the code under test is explicitly date-based.

For changes that cannot be built in the current environment,
run the strongest available direct verification,
such as reading the affected files,
checking the Xcode project references,
and running whitespace checks on new Markdown files.

## Repository Hygiene

Do not commit local build output,
DerivedData,
Swift Package caches,
Xcode user state,
or generated SwiftGen outputs.
The existing `.gitignore` already covers the common local and generated artifacts.

Do not store secrets,
provisioning profiles,
signing certificates,
or private team credentials in the repository.
Be careful when editing bundle identifiers,
development-team settings,
entitlements,
and signing configuration,
because those can affect release and provisioning workflows.
