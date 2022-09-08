//
//  PomodoroProgressViewStyle.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-08.
//
//

import Foundation
import SwiftUI


// MARK: PomodoroProgressViewStyle

/// Undocumented.
///
/// - Todo: Document.
///
struct PomodoroProgressViewStyle: ProgressViewStyle {

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var theme: Theme

    // MARK: - Methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    //      - configuration:
    /// - Returns:
    ///
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                    .if(.iOS15) { $0.fill(theme.foregroundColor) }
                    .frame(height: 20.0)
            ProgressView(configuration)
                    .if(.iOS15) { $0.tint(theme.backgroundColor) }
                    .frame(height: 12.0)
                    .padding(.horizontal)
        }
    }
}

// MARK: PomodoroProgressViewStyle_Previews

/// Undocumented.
///
/// - Todo: Document.
///
struct PomodoroProgressViewStyle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(value: 0.4)
                .progressViewStyle(PomodoroProgressViewStyle(theme: .yellow))
                .previewLayout(.sizeThatFits)
    }
}