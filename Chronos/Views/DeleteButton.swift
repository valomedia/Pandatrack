//
//  DeleteButton.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-28.
//
//

import Foundation
import SwiftUI


// MARK: DeleteButton

/// Undocumented.
///
/// - Todo: Document.
///
struct DeleteButton: View {

    // MARK: - Static properties

    // MARK: - Class methods

    // MARK: - Life cycle methods

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var buttonText: LocalizedStringKey

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var confirmationQuestion: LocalizedStringKey

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var supplementalMessage: LocalizedStringKey?

    var body: some View {
        Button(role: .destructive, action: { isPresentingConfirmationDialog = true }) {
            HStack {
                Spacer()
                Text(buttonText)
                Spacer()
            }
        }
                .confirmationDialog(
                        confirmationQuestion,
                        isPresented: $isPresentingConfirmationDialog,
                        titleVisibility: .visible) {
                    Button(buttonText, role: .destructive, action: action)
                } message: {
                    if let supplementalMessage { Text(supplementalMessage) }
                }
    }

    @State private var isPresentingConfirmationDialog = false

    // MARK: - Methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var action: () -> Void

}


// MARK: DeleteButton_Previews

class DeleteButton_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        NavigationView {
            List {
                Section {
                    DeleteButton(
                            buttonText: "Delete all the things!",
                            confirmationQuestion: "Really delete all the things?") {}
                }
            }
        }
    }

}