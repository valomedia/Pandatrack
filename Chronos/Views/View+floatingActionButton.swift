//
//  View+floatingActionButton.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-18.
//
//

import Foundation
import SwiftUI


// MARK: View

extension View {

    func floatingActionButton(
            image: Image? = nil,
            accessibilityIdentifier: String? = nil,
            action: (()->())? = nil) -> some View {
        ZStack {
            self
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    FloatingActionButton(
                            image: image,
                            accessibilityIdentifier: accessibilityIdentifier,
                            action: action)
                }
            }
        }
    }

}
