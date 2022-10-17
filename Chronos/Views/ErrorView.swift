//
//  ErrorView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation
import SwiftUI


// MARK: ErrorView

/// Undocumented.
///
/// - Todo: Document.
///
struct ErrorView: View {

    // MARK: - Static properties

    // MARK: - Static methods

    // MARK: - Life cycle methods

    // MARK: - Properties

    var body: some View {
        NavigationView {
            NoContentView(
                    title: "An error has occurred!",
                    headline: errorWrapper.error.localizedDescription,
                    caption: errorWrapper.guidance)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Dismiss") {
                                dismiss()
                            }
                        }
                    }
        }
    }

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    let errorWrapper: ErrorWrapper

    @Environment(\.dismiss)
    private var dismiss

    // MARK: - Methods
}

// MARK: ErrorView_Previews

/// Undocumented.
///
/// - Todo: Document
///
class ErrorView_Previews: PreviewProvider {

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    enum SampleError: Error {
        case errorRequired
    }

    // MARK: - Static properties

    /// Undocumented.
    ///
    /// - Todo: Document
    ///
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired, guidance: "You can safely ignore this error.")
    }

    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }

}
