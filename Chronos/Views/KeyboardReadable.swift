//
//  KeyboardReadable.swift
//  Chronos
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
