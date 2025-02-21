//
//  View+enabled.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-25.
//
//

import Foundation
import SwiftUI


// MARK: View

extension View {

    // MARK: + enabled

    @ViewBuilder func enabled(_ enabled: Bool) -> some View {
        disabled(!enabled)
    }
}
