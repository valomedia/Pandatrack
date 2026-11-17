//
//  SectionedFetchResults-Section+Equatable.swift
//  Chronos
//

import Foundation
import SwiftUI


// MARK: SectionedFetchResults.Section

// MARK: + Equatable

extension SectionedFetchResults.Section: @retroactive Equatable where SectionIdentifier: Equatable {

    public static func ==(lhs: SectionedFetchResults.Section, rhs: SectionedFetchResults.Section) -> Bool {
        lhs.id == rhs.id
    }

}
