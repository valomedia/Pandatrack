//
//  TabBarTab.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-05.
//
//

import Foundation
import SwiftUI


// MARK: Tab

/// Undocumented.
///
/// - Todo: Document.
///
protocol TabBarTab: RawRepresentable, CaseIterable, Identifiable, Hashable
        where RawValue: Hashable, AllCases == Array<Self> {

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var image: Image { get }

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var text: Text { get }

}

extension TabBarTab {

    // MARK: + id

    var id: RawValue { rawValue }

}
