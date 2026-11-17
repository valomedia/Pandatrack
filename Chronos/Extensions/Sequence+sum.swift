//
//  Sequence+sum.swift
//  Chronos
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
