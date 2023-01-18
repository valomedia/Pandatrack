//
//  KeyboardReadable.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2023-01-17.
//
//

import Foundation
import Combine
import UIKit


// MARK: KeyboardReadable

/// Undocumented.
///
/// - Todo: Document.
///
protocol KeyboardReadable {

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }

}

// MARK: + keyboardPublisher

extension KeyboardReadable {

    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers
                .Merge(
                        NotificationCenter
                                .default
                                .publisher(for: UIResponder.keyboardWillShowNotification)
                                .map { _ in true },
                        NotificationCenter
                                .default
                                .publisher(for: UIResponder.keyboardWillHideNotification)
                                .map { _ in false }
                )
                .eraseToAnyPublisher()
    }

}
