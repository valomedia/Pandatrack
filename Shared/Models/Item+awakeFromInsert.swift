//
//  Item+awakeFromInsert.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation


// MARK: Item

// MARK: + awakeFromInsert

extension Item {

    // MARK: - Life cycle methods

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        primitiveId = UUID()
        primitiveTimestamp = Date()
    }
}
