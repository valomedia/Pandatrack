//
//  Sequence+compacted.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-12.
//
//

import Foundation


extension Sequence {

    @inlinable func compacted<Unwrapped>() -> [Unwrapped] where Element == Unwrapped? {
        self.compactMap { $0 }
    }

}