//
//  Sequence+reduce.swift
//  Chronos
//

import Foundation


// MARK: Sequence

extension Sequence {

    // MARK: + reduce

    @inlinable
    public func reduce<Result>(
            _ nextPartialResult: (_ partialResult: Result?, Self.Element) throws -> Result
    ) rethrows -> Result {
        try self.reduce(nil, nextPartialResult)!
    }

}
