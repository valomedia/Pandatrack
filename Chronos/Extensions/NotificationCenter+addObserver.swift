//
//  NotificationCenter+addObserver.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-28.
//
//

import Foundation


// MARK: NotificationCenter

extension NotificationCenter {

    // MARK: + addObserver

    /// Adds entries to the notification center for multiple names.
    ///
    /// This will call addObserver(formane:object:queue:using:) for each provided NSNotification.Name
    ///
    /// - Parameters:
    ///     - names: The names of the notifications to register for delivery to the observer block.
    ///     - obj: The object that sends notifications to the observer block.
    ///     - queue: The operation queue where the block runs.
    ///     - block: The block that executes when receiving a notification.
    /// - Returns: Opaque objects to act as the observers.
    ///
    @discardableResult
    func addObserver(
            forNames names: [NSNotification.Name],
            object obj: Any?,
            queue: OperationQueue?,
            using block: @escaping @Sendable (Notification) -> Void
    ) -> [NSObjectProtocol] {
        names.map { name in self.addObserver(forName: name, object: obj, queue: queue, using: block) }
    }
}