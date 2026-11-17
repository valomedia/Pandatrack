//
//  Sequence+compacted.swift
//  Chronos
//

import Foundation


extension Sequence {

    @inlinable func compacted<Unwrapped>() -> [Unwrapped] where Element == Unwrapped? {
        self.compactMap { $0 }
    }

}