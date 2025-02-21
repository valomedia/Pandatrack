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

struct ErrorView: View {

    // MARK: - Properties

    let errorWrapper: ErrorWrapper

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

    @Environment(\.dismiss)
    private var dismiss

}


// MARK: ErrorView_Previews

class ErrorView_Previews: PreviewProvider {

    enum SampleError: Error {
        case errorRequired
    }

    // MARK: - Static properties

    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired, guidance: "You can safely ignore this error.")
    }

    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }

}
