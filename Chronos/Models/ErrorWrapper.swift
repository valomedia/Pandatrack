//
//  ErrorWrapper.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
//

import Foundation


// MARK: ErrorWrapper

struct ErrorWrapper: Identifiable {

    // MARK: - Properties

    let id: UUID = UUID()

    let error: Error

    let guidance: String

}
