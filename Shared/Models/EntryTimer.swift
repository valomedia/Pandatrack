//
//  EntryTimer.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-06.
//
//

import Foundation


// MARK: EntryTimer

///
/// Keeps time for an Entry.
class EntryTimer: ObservableObject {

    // MARK: - Static properties

    // MARK: - Class methods

    // MARK: - Life cycle methods

    // MARK: - Properties

    ///
    /// The PomodoroTimer for this entry.
    @Published
    var pomodoroTimer: PomodoroTimer?

    ///
    /// The number of seconds the entry has been running for.
    @Published
    var secondsElapsed: Int?

    ///
    /// The number of minutes the entry has been running for.
    @Published
    var minutesElapsed: Int?

    ///
    /// The number of hours the entry has been running for.
    @Published
    var hoursElapsed: Int?

    ///
    /// The elapsed time formatted as hh:mm:ss.
    @Published
    var timeElapsedString: String?

    ///
    /// The elapsed time in words.
    @Published
    var timeElapsedAccessibilityLabel: String?

    ///
    /// Whether the Timer is currently running.
    ///
    /// This will reflect whether the timer is currently active. This only shows whether the EntryTimer is currently
    /// updating its fields and notifying subscribers once per second. It has nothing to do with the state of the
    /// actual Entry. In order to figure out whether the EntryTimer is currently tracking an Entry, check whether
    /// `entry` is set.
    @Published
    var timerStopped = true

    ///
    /// The Entry that is running.
    var entry: Entry?

    private let frequency = 1.0 / 60.0
    private var timer: Timer?

    // MARK: - Methods

    ///
    /// Start a new Entry.
    ///
    /// This will stop the current Entry if one is running, removing it from the context if it was unnamed and start
    // tracking the given Entry.
    ///
    /// - Parameters:
    ///     - entry: The Entry to start tracking.
    /// - Returns: The Entry that has ended or nil if the Entry was not running or unnamed.
    func track(_ entry: Entry) -> Entry? {
        let result = reset()

        self.entry = entry
        update()

        return result
    }

    ///
    /// Reset this EntryTimer.
    ///
    /// This will stop the clock and reset it to zero for the next entry. It will take the current Entry and return it,
    /// if it was running and named, removing it from its context (if applicable) and returning nil otherwise.
    ///
    /// - Returns: The Entry that has just ended, or nil if the Entry was not running or unnamed.
    func reset() -> Entry? {
        let result: Entry?
        if let entry = entry, entry.name != "" {
            result = entry
        } else {
            result = nil
        }

        zero()
        return result
    }

    ///
    /// Either start of stop the timer if needed.
    ///
    /// This is a convenience function for automatically calling `startTimer()`, or `stopTimer()` given a boolean
    /// value.
    ///
    /// - Parameters:
    ///     - timerShouldBeStopped: If `true`, the Timer is stopped if running. Otherwise, it is started if stopped.
    /// - Returns: The EntryTimer
    func setTimer(timerShouldBeStopped: Bool) -> EntryTimer {
        timerShouldBeStopped ? stopTimer() : startTimer()
    }

    ///
    /// Start counting seconds.
    ///
    /// This will start the timer, notifying every observer once a second. This has nothing to do with whether the
    /// Entry itself is running or not.
    ///
    /// - Returns: The EntryTimer
    func startTimer() -> EntryTimer {
        guard timerStopped else {
            return self
        }

        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            guard let self = self else {
                return
            }
            self.update()
        }
        timerStopped = false

        return self
    }

    ///
    /// Stop counting seconds.
    ///
    /// This can be used to stop the Timer again, to prevent pointless churn when the Timer isn't visible anywhere on
    /// screen.
    ///
    /// - Returns: The EntryTimer
    func stopTimer() -> EntryTimer {
        timer?.invalidate()
        timer = nil
        timerStopped = true
        return self
    }

    private func update() {
        guard let entry = entry else {
            return
        }

        let secondsElapsed = Int(Date().timeIntervalSince1970 - entry.start.timeIntervalSince1970)
        self.secondsElapsed = secondsElapsed

        let minutesElapsed = secondsElapsed / 60
        self.minutesElapsed = minutesElapsed

        let hoursElapsed = minutesElapsed / 60
        self.hoursElapsed = hoursElapsed

        let hh = hoursElapsed
        let mm = minutesElapsed % 60
        let ss = secondsElapsed % 60

        timeElapsedString = String(format: "%02d:%02d:%02d", hh, mm, ss)
        timeElapsedAccessibilityLabel = "\(hh) hours, \(mm) minutes, and \(ss) seconds"
    }

    private func zero() {
        secondsElapsed = 0
        minutesElapsed = 0
        hoursElapsed = 0
        timeElapsedString = "00:00:00"
        timeElapsedAccessibilityLabel = "0 hours, 0 minutes, and 0 seconds"
    }
}
