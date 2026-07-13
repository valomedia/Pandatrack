//
//  LeadingIconLabelStyle.swift
//  Chronos
//

import Foundation
import SwiftUI


// MARK: LeadingIconLabelStyle

struct LeadingIconLabelStyle: LabelStyle {

    // MARK: Methods

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon.frame(width: 10)
            configuration.title
        }
    }

}

// MARK: LabelStyle

// MARK: + LeadingIconLabelStyle

extension LabelStyle where Self == LeadingIconLabelStyle {

    // MARK: - Static properties

    static var leadingIcon: Self {
        Self()
    }

}
