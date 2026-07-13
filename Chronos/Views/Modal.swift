//
//  Modal.swift
//  Chronos
//

import Foundation
import SwiftUI


// MARK: Modal

struct Modal<Content: View, S: StringProtocol>: View {

    // MARK: - Life cycle methods

    init(
            _ title: S? = nil,
            onOpen: (() -> Void)? = nil,
            onClose: (() -> Void)? = nil,
            @ViewBuilder content: @escaping () -> Content) {
        self.title = title ?? ""
        self.content = content
        self.onOpen = onOpen ?? {}
        self.onClose = onClose ?? {}
    }

    // MARK: - Properties

    var body: some View {
        NavigationView {
            Group {
                if isContentPresented {
                    content()
                }
            }
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
                .onAppear(perform: open)
                .onDisappear(perform: close)
    }

    @State private var isContentPresented = false

    private var title: S
    private var content: () -> Content

    @EnvironmentObject private var env: ChronosEnvironment

    @Environment(\.dismiss)
    private var dismiss

    // MARK: - Methods

    private let onOpen: () -> Void
    private let onClose: () -> Void

    private func open() {
        guard !isContentPresented else { return }

        env.waitForConfirmation()
        onOpen()
        isContentPresented = true
    }

    private func close() {
        isContentPresented = false
        onClose()
        env.discardChanges()
    }

}
