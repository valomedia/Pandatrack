//
//  ErrorWrapper.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation


// MARK: ErrorWrapper

/// Undocumented.
///
/// - Todo: Document.
///
struct ErrorWrapper: Identifiable {

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let id: UUID = UUID()

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let error: Error

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let guidance: String

}
