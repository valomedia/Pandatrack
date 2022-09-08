//
//  LeadingIconLabelStyle.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-07.
//
//

import Foundation
import SwiftUI


// MARK: LeadingIconLabelStyle

/**
 - Todo: Document.
 */
struct LeadingIconLabelStyle: LabelStyle {

    // MARK: Methods

    /**
     - Todo: Document.
     - Parameter configuration:
     - Returns:
     */
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon.frame(width: 10)
            configuration.title
        }
    }
}

// MARK: LabelStyle

// MARK: + LeadingIconLabelStyle

/**
 - Todo: Document.
 */
extension LabelStyle where Self == LeadingIconLabelStyle {

    // MARK: - Static properties

    /**
     - Todo: Document.
     */
    static var leadingIcon: Self { Self() }
}
