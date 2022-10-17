//
//  Project+awakeFromInsert.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-05-11.
//
//

import Foundation
import CoreData


// MARK: Project

extension Project {

    // MARK: + awakeFromInsert

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        primitiveId = UUID()
        primitiveTimestamp = Date()
    }

}
