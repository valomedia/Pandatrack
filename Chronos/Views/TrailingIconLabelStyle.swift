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

struct TrailingIconLabelStyle: LabelStyle {

    // MARK: Methods

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon.frame(width: 10)
        }
    }

}


// MARK: LabelStyle

extension LabelStyle where Self == TrailingIconLabelStyle {

    // MARK: + TrailingIconLabelStyle

    static var trailingIcon: Self { Self() }

}
