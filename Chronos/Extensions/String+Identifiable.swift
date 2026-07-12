//
//  String+Identifiable.swift
//  Chronos
//

import Foundation


// MARK: String

// MARK: + Identifiable

extension String: @retroactive Identifiable {
    public typealias ID = Int

    public var id: Int {
        hash
    }

}
