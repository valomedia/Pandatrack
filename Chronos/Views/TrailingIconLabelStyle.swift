//
//  TrailingIconLabelStyle.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-02-07.
//
//

import Foundation
import SwiftUI


// MARK: TrailingIconLabelStyle

/**
 - Todo: Document.
 */
struct TrailingIconLabelStyle: LabelStyle {

    // MARK: Methods

    /**
     - Todo: Document.
     - Parameter configuration:
     - Returns:
     */
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon.frame(width: 10)
        }
    }
}

// MARK: LabelStyle

// MARK: + TrailingIconLabelStyle

/**
 - Todo: Document.
 */
extension LabelStyle where Self == TrailingIconLabelStyle {

    /**
     - Todo: Document.
     */
    static var trailingIcon: Self { Self() }
}
