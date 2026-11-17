//
//  TabBarTab.swift
//  Chronos
//

import Foundation
import SwiftUI


// MARK: Tab

protocol TabBarTab: RawRepresentable, CaseIterable, Identifiable, Hashable
        where RawValue: Hashable, AllCases == Array<Self> {

    // MARK: - Properties

    var image: Image { get }

    var text: Text { get }

}

extension TabBarTab {

    // MARK: + id

    var id: RawValue { rawValue }

}
