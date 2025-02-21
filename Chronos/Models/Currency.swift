//
//  Currency.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-19.
//
//

import Foundation


// MARK: Currency

struct Currency: Codable, CustomStringConvertible {

    // MARK: Life cycle methods

    init(_ amount: Decimal, code: String = Locale.current.currency?.identifier ?? "USD") {
        self.amount = amount
        self.code = code
    }

    init() {
        self.init(0)
    }

    // MARK: Properties

    let code: String

    let amount: Decimal

    var description: String {
        "\(amount) \(code)"
    }

}
