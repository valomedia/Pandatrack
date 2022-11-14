//
//  Optional+Comparable.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-14.
//
//

import Foundation


// MARK: Optional

extension Optional: Comparable where Wrapped: Comparable {

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