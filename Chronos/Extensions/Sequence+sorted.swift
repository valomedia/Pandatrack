//
//  Sequence+sorted.swift
//  Chronos
//

import Foundation


// MARK: Sequence

extension Sequence {

    // MARK: + sorted

    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }

}
