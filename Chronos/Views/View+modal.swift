//
//  View+modal.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation
import SwiftUI


// MARK: View

extension View {

    // MARK: + modal

    /// Undocumented.
    ///
    /// - Todo: Document
    /// - Parameters:
    ///   - env:
    ///   - title:
    ///   - isPresented:
    ///   - content:
    /// - Returns:
    ///
    @ViewBuilder
    func modal<Content: View, S: StringProtocol>(
            _ env: ChronosEnvironment,
            title: S? = nil,
            isPresented: Binding<Bool>,
            @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.sheet(
                isPresented: Binding(
                        get: { isPresented.wrappedValue },
                        set: { newValue in
                            isPresented.wrappedValue = newValue
                            if !newValue { env.discardChanges() }
                        })) {
            NavigationView {
                content()
                        .ifNotNil(title) { $0.navigationTitle($1.isEmpty ? "Untitled" : $1) }
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresented.wrappedValue = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    env.confirmChanges()
                                    isPresented.wrappedValue = false
                                }
                            }
                        }
                        .onAppear(perform: env.waitForConfirmation)
            }
        }
    }

}
