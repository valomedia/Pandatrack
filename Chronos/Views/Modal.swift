//
//  Modal.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-14.
//
//

import Foundation
import SwiftUI


// MARK: Modal

/// Undocumented.
///
/// - Todo: Document.
///
struct Modal<Content: View, S: StringProtocol>: View {

    // MARK: - Static properties

    // MARK: - Class methods

    // MARK: - Life cycle methods

    init(_ title: S? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.title = title ?? ""
        self.content = content
    }

    // MARK: - Properties

    var body: some View {
        NavigationView {
            content()
                    .navigationTitle(title.isEmpty ? "Untitled" : title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                dismiss()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                env.confirmChanges()
                                dismiss()
                            }
                        }
                    }
        }
                .onAppear(perform: env.waitForConfirmation)
                .onDisappear(perform: env.discardChanges)
    }

    private var title: S
    private var content: () -> Content

    @EnvironmentObject private var env: ChronosEnvironment

    @Environment(\.dismiss) private var dismiss

    // MARK: - Methods
}
