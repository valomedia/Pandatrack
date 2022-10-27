//
//  EntryTimer.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-06.
//
//

import Foundation
import CoreData


// MARK: EntryTimer

/// Keeps time for an Entry.
///
class EntryTimer: ObservableObject {

    // MARK: - Static properties

    /// The EntryTimer singleton instance.
    ///
    static var shared = EntryTimer()

    // MARK: - Life cycle methods

    fileprivate init() {
        zero()
    }

    // MARK: - Properties

    /// The PomodoroTimer for this entry.
    ///
    @Published var pomodoroTimer: PomodoroTimer?

    /// The number of seconds the entry has been running for.
    ///
    @Published var secondsElapsed: Int?

    /// The number of minutes the entry has been running for.
    ///
    @Published var minutesElapsed: Int?

    /// The number of hours the entry has been running for.
    ///
    @Published var hoursElapsed: Int?

    /// The elapsed time formatted as hh:mm:ss.
    ///
    @Published var timeElapsedString: String?

    /// The elapsed time in words.
    ///
    @Published var timeElapsedAccessibilityLabel: String?

    /// Whether the Timer is currently running.
    ///
    ///
    /// This will reflect whether the timer is currently active. This only shows whether the EntryTimer is currently
    /// updating its fields and notifying subscribers once per second. It has nothing to do with the state of the
    /// actual Entry. In order to figure out whether the EntryTimer is currently tracking an Entry, check whether
    /// `entry` is set.
    ///
    @Published var timerStopped = true

    /// The Entry that is running.
    ///
    @Published var entry: Entry?

    private let frequency = 1.0 / 60.0
    private var timer: Timer?

    // MARK: - Methods

    /// Start a given Entry.
    ///
    /// This will stop the current Entry if one is running, removing it from the context if it was unnamed and start
    /// tracking the given Entry.
    ///
    /// - Parameters:
    ///     - entry: The Entry to start tracking.
    /// - Returns: The EntryTimer
    ///
    @discardableResult func track(_ entry: Entry) -> EntryTimer {
        reset()
        self.entry = entry
        pomodoroTimer = PomodoroTimer(startDate: entry.start)
        update()
        return self
    }

    /// Start a new Entry.
    ///
    /// This will stop the current Entry if one is running, create a new entry with the given information and start
    /// tracking.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - context:
    ///     - name:
    ///     - start:
    ///     - project:
    ///     - tags:
    /// - Returns: The EntryTimer
    ///
    @discardableResult func track(
            _ context: NSManagedObjectContext,
            name: String? = nil,
            start: Date? = nil,
            project: Project? = nil,
            tags: Set<Tag>? = nil
    ) -> EntryTimer {
        track(Entry(context, name: name, start: start, project: project, tags: tags))
    }

    /// Continue a given Entry.
    ///
    /// This will stop the current Entry if one is running, create a new entry with the given information and start
    /// tracking.
    ///
    /// - Parameters:
    ///     - context: The NSManagedObjectContext to add the new Entry to
    ///     - entry: The Entry to continue
    /// - Returns: The EntryTimer
    ///
    @discardableResult func track(_ context: NSManagedObjectContext, continueFrom entry: Entry) -> EntryTimer {
        track(Entry(context, continueFrom: entry))
    }

    /// Reset this EntryTimer.
    ///
    /// This will stop the Entry and reset the clock to zero for the next entry.
    ///
    /// - Returns: The EntryTimer
    ///
    @discardableResult func reset() -> EntryTimer {
        entry?.end = Date()
        zero()
        return self
    }

    /// Either start of stop the timer if needed.
    ///
    /// This is a convenience function for automatically calling `startTimer()`, or `stopTimer()` given a boolean
    /// value.
    ///
    /// - Parameters:
    ///     - timerShouldBeStopped: If `true`, the Timer is stopped if running. Otherwise, it is started if stopped.
    ///
    func setTimer(timerShouldBeStopped: Bool) {
        timerShouldBeStopped ? stopTimer() : startTimer()
    }

    /// Start counting seconds.
    ///
    /// This will start the timer, notifying every observer once a second. This has nothing to do with whether the
    /// Entry itself is running or not.
    ///
    func startTimer() {
        guard timerStopped else { return }

        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            guard let self = self else {
                return
            }
            self.update()
        }
        timerStopped = false
    }

    /// Stop counting seconds.
    ///
    /// This can be used to stop the Timer again, to prevent pointless churn when the Timer isn't visible anywhere on
    /// screen.
    ///
    ///
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timerStopped = true
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
        pomodoroTimer = nil
        entry = nil
    }

}
