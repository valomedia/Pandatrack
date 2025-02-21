//
//  Sorted.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-14.
//
//

import Foundation


// MARK: Sorted

@propertyWrapper class Sorted<Element, Key: Comparable>: RandomAccessCollection {
    typealias Index = AnyRandomAccessCollection<Element>.Index
    typealias Indices = AnyRandomAccessCollection<Element>.Indices
    typealias Element = AnyRandomAccessCollection<Element>.Element
    typealias SubSequence = AnyRandomAccessCollection<Element>.SubSequence

    // MARK: - Life cycle methods

    init(_ wrappedValue: AnyCollection<Element>? = nil, by keyPath: KeyPath<Element, Key>) {
        self.wrappedValue = wrappedValue ?? AnyCollection([])
        self.keyPath = keyPath
    }

    convenience init(wrappedValue: AnyCollection<Element>, by keyPath: KeyPath<Element, Key>) {
        self.init(wrappedValue, by: keyPath)
    }

    // MARK: - Properties

    var keyPath: KeyPath<Element, Key>

    var wrappedValue: AnyCollection<Element>

    var projectedValue: AnyRandomAccessCollection<Element> {
        AnyRandomAccessCollection(wrappedValue.sorted(by: keyPath))
    }

    var indices: Indices { projectedValue.indices }
    var startIndex: Index { projectedValue.startIndex }
    var endIndex: Index { projectedValue.endIndex }

    // MARK: - Methods

    subscript(position: Index) -> Element { projectedValue[position] }
    subscript(bounds: Range<Index>) -> SubSequence { projectedValue[bounds] }

    func index(before i: Index) -> Index { projectedValue.index(before: i) }
    func index(after i: Index) -> Index { projectedValue.index(after: i) }

}

extension Sorted where Element == Key {

    convenience init(_ wrappedValue: AnyCollection<Element>? = nil) {
        self.init(wrappedValue, by: \.self)
    }

    convenience init(wrappedValue: AnyCollection<Element>) {
        self.init(wrappedValue)
    }

}
