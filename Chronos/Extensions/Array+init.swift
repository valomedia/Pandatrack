//
//  Array+init.swift
//  Chronos
//

import Foundation


// MARK: Array

// MARK: + init

extension Array {

    init(collecting value: Element, using keyPath: KeyPath<Element, Element?>) {
        self.init()
        var element: Element? = value
        while (element != nil) {
            self.append(element!)
            element = element![keyPath: keyPath]
        }
    }

}
