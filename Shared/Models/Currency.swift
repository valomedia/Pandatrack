//
//  Currency.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: Currency

/**
 - Todo: Document.
 */
public struct Currency: Codable, CustomStringConvertible {

    // MARK: Life cycle methods

    /**
     - Todo: Document
     - Parameters:
       - amount:
       - code:
     */
    public init(_ amount: Decimal, code: String = Locale.current.currencyCode ?? "USD") {
        self.amount = amount
        self.code = code
    }

    // MARK: Properties

    /**
     - Todo: Document.
     */
    public let code: String

    /**
     - Todo: Document.
     */
    public let amount: Decimal

    /**
     - Todo: Document.
     */
    public var description: String {
        "\(amount) \(code)"
    }
}
