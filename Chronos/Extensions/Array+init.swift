//
//  Array+init.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2023-01-28.
//
//

import Foundation


// MARK: Array

// MARK: + init

extension Array {

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - value:
    ///     - keyPath:
    ///
    init(collecting value: Element, using keyPath: KeyPath<Element, Element?>) {
        self.init()
        var element: Element? = value
        while (element != nil) {
            self.append(element!)
            element = element![keyPath: keyPath]
        }
    }

}