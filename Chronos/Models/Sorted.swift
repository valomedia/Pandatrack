//
//  Sorted.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-14.
//
//

import Foundation


// MARK: Sorted

/// Undocumented.
///
/// - Todo: Document.
///
@propertyWrapper class Sorted<Element: Comparable> {

    // MARK: - Life cycle methods

    init(wrappedValue: [Element]) {
        _wrappedValue = wrappedValue
    }

    convenience init(_ wrappedValue: [Element]) {
        self.init(wrappedValue: wrappedValue)
    }

    // MARK: - Properties

    var wrappedValue: [Element] {
        get { _wrappedValue.sorted() }
        set { _wrappedValue = newValue }
    }
    private var _wrappedValue: [Element]

}
