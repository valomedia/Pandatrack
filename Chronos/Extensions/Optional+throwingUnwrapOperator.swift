//
//  Optional+throwingUnwrapOperator.swift
//  Chronos
//

import Foundation

postfix operator .!?


// MARK: Optional

extension Optional {

    // MARK: + throwingUnwrapOperator

    static postfix func .!?(_ optional: Optional) throws -> Wrapped {
        guard let wrapped = optional else { throw UnwrapError() }
        return wrapped
    }

    // MARK: + UnwrapError

    struct UnwrapError: Error {}

}
