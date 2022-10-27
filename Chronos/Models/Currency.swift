//
//  Currency.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: Currency

/// Undocumented.
///
/// - Todo: Document.
///
struct Currency: Codable, CustomStringConvertible {

    // MARK: Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document
    /// - Parameters:
    ///     - amount:
    ///     - code:
    ///
    init(_ amount: Decimal, code: String = Locale.current.currencyCode ?? "USD") {
        self.amount = amount
        self.code = code
    }

    // MARK: Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let code: String

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    let amount: Decimal

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var description: String {
        "\(amount) \(code)"
    }

}
