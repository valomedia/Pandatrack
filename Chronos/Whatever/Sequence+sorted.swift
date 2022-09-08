//
//  Sequence+sorted.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-08.
//
//

import Foundation


// MARK: Sequence

// MARK: + sorted

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}