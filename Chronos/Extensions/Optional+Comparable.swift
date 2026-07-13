//
//  Optional+Comparable.swift
//  Chronos
//

import Foundation


// MARK: Optional

extension Optional: @retroactive Comparable where Wrapped: Comparable {

    // MARK: + Comparable

    public static func <(lhs: Optional, rhs: Optional) -> Bool {
        if let lhs = lhs {
            if let rhs = rhs {
                return lhs < rhs
            } else {
                return false
            }
        } else {
            return rhs != nil
        }
    }

}
