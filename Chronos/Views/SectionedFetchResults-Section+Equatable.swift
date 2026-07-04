//
//  SectionedFetchResults-Section+Equatable.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-07.
//
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
