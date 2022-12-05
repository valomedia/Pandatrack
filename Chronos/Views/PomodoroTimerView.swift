//
//  PomodoroTimerView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-08.
//
//

import Foundation
import SwiftUI
import ObservedOptionalObject


// MARK: PomodoroTimerView

/// Undocumented.
///
/// - Todo: Document.
///
struct PomodoroTimerView: View {

    // MARK: - Properties

    /// Undocumented
    ///
    /// - Todo: Document.
    ///
    @ObservedOptionalObject var pomodoroTimer: PomodoroTimer?

    /// Undocumented
    ///
    /// - Todo: Document.
    ///
    let theme: Theme

    var body: some View {
        VStack {
            Text("Pomodoro Timer")
                    .frame(alignment: .center)
                    .font(.headline)
            ProgressView(
                    value: Double(pomodoroTimer?.secondsElapsed ?? 0),
                    total: Double(pomodoroTimer?.totalSeconds ?? 1)
            )
                    .progressViewStyle(PomodoroProgressViewStyle(theme: theme))
            HStack {
                VStack(alignment: .leading) {
                    Text("Minutes Elapsed")
                            .font(.caption)
                    Label(
                            (pomodoroTimer?.minutesElapsed).map(String.init) ?? "",
                            systemImage: "hourglass.bottomhalf.fill"
                    )
                            .labelStyle(.leadingIcon)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Minutes Remaining")
                            .font(.caption)
                    Label(
                            (pomodoroTimer?.minutesRemaining).map(String.init) ?? "",
                            systemImage: "hourglass.tophalf.fill"
                    )
                            .labelStyle(.trailingIcon)
                }
            }
        }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Time remaining")
                .ifNotNil(pomodoroTimer) { $0.accessibilityValue("\($1.minutesRemaining) minutes") }
                .accessibilityHidden(pomodoroTimer == nil)
                .padding()
                .onAppear { pomodoroTimer?.startTimer() }
                .onDisappear { pomodoroTimer?.stopTimer() }
    }

}

// MARK: PomodoroTimerView_Previews

/// Undocumented.
///
/// - Todo: Document.
///
struct PomodoroTimerView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        PomodoroTimerView(pomodoroTimer: PomodoroTimer(), theme: .yellow)
                .previewLayout(.sizeThatFits)
    }

}
