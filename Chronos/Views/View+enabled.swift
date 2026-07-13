//
//  View+enabled.swift
//  Chronos
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
