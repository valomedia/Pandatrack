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

struct PomodoroProgressViewStyle: ProgressViewStyle {

    // MARK: - Properties

    let theme: Theme

    // MARK: - Methods

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

struct PomodoroProgressViewStyle_Previews: PreviewProvider {

    static var previews: some View {
        ProgressView(value: 0.4)
                .progressViewStyle(PomodoroProgressViewStyle(theme: .yellow))
                .previewLayout(.sizeThatFits)
    }

}
