//
//  ErrorWrapper.swift
//  Chronos
//

import Foundation


// MARK: ErrorWrapper

struct ErrorWrapper: Identifiable {

    // MARK: - Properties

    let id: UUID = UUID()

    let error: Error

    let guidance: String

}
