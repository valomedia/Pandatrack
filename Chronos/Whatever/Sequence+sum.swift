//
//  Sequence+sum.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation


// MARK: Sequence

extension Sequence where Element: AdditiveArithmetic {

    // MARK: + sum

    /// Calculetes the total of any sequence with `AdditiveArithmetic` elements.
    ///
    /// - Returns: The sum of the sequence
    ///
    func sum() -> Element {
        reduce(.zero, +)
    }

}