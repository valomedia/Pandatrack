//
//  String+Identifiable.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2023-01-20.
//
//

import Foundation


// MARK: String

// MARK: + Identifiable

extension String: Identifiable {
    public typealias ID = Int

    public var id: Int {
        hash
    }

}