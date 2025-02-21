//
//  PomodoroTimer.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-06.
//
//

import Foundation


// MARK: PomodoroTimer

class PomodoroTimer: ObservableObject {

    // MARK: - Life cycle methods

    /// Initialize a PomodoroTimer with a TimeInterval.
    ///
    /// - Note: Use `startTimer()` to the start the Timer.
    /// - Parameters:
    ///     - startDate: A start Date for the timer. Defaults to now.
    ///     - timeInterval: A TimeInterval for the length of each pomodoro, defaults to 25 minutes.
    ///
    init(startDate: Date = Date(), timeInterval: TimeInterval = TimeInterval(25 * 60)) {
        self.startDate = startDate
        totalSeconds = Int(timeInterval)
        totalMinutes = totalSeconds / 60
        secondsElapsed = 0
        secondsRemaining = totalSeconds
        minutesElapsed = 0
        minutesRemaining = totalMinutes
        progress = 0
    }

    // MARK: - Properties

    /// The total length of each pomodoro in minutes.
    ///
    let totalMinutes: Int

    /// The total length of each pomodoro in seconds.
    ///
    let totalSeconds: Int

    /// The starting Date of the first pomodoro.
    ///
    let startDate: Date

    /// The number of seconds in the current pomodoro that have already elapsed.
    ///
    @Published var secondsElapsed: Int

    /// The number of seconds in the corrent pomodoro that are still remaining.
    ///
    @Published var secondsRemaining: Int

    /// The progress of the current pomodoro as a floating-point value between 0 and 1.
    ///
    @Published var progress: Double

    /// The number of minutes in the current pomodoro that have already elapsed.
    ///
    @Published var minutesElapsed: Int

    /// The number of minutes in the current pomodoro that are still remaining.
    ///
    @Published var minutesRemaining: Int

    private let frequency: TimeInterval = 1.0 / 60.0
    private var timer: Timer?
    private var timerStopped = true

    // MARK: - Methods

    /// Start the Timer.
    ///
    /// This with start the Timer, notifying every observer once a second. This is unrelated the the progress of the
    /// actual pomodoro. Rather if the Timer is stopped and later restarted, it will just skip ahead to the correct
    /// time in the pomodoro, to give the impression that the pomodoro has always been running.
    ///
    func startTimer() {
        if timerStopped {
            timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
                if let self = self {
                    let secondsElapsed = Date().timeIntervalSince1970 - self.startDate.timeIntervalSince1970
                    self.update(secondsElapsed: Int(secondsElapsed) % self.totalSeconds)
                }
            }
            timerStopped = false
        }
    }

    /// Stop the Timer.
    ///
    /// This will stop the Timer. It will not stop the actual pomodoro. This method is only used to prevent pointless
    /// churn when the pomodoro isn't actually visible on screen.
    ///
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timerStopped = true
    }

    private func update(secondsElapsed: Int) {
        self.secondsElapsed = secondsElapsed
        secondsRemaining = totalSeconds - secondsElapsed
        minutesElapsed = secondsElapsed / 60
        minutesRemaining = totalMinutes - minutesElapsed
        progress = totalSeconds > 0 ? Double(secondsElapsed)  / Double(totalSeconds) : 0
    }

}
