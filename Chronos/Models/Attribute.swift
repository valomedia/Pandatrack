//
//  Attribute.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-13.
//
//

import Foundation


// MARK: Attribute

protocol Attribute {

    // MARK: - Properties

    var description: String { get }

    var localizedDescription: String { get }

    var accessibilityDescription: String { get }

}
