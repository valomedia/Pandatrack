//
//  Binding+subscript.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-06.
//
//

import Foundation
import SwiftUI


// MARK: Binding

extension Binding {

    // MARK: + subscript

    subscript<WrappedValue, WrappedSubject>(_ keyPath: WritableKeyPath<WrappedValue, WrappedSubject>)
			-> Binding<WrappedSubject?> where Value == WrappedValue? {
		.init(
				get: {
					wrappedValue?[keyPath: keyPath]
				},
				set: { newValue in
					if let newValue = newValue {
						wrappedValue?[keyPath: keyPath] = newValue
					} else {
						wrappedValue = nil
					}
				}
		)
    }

	subscript<WrappedValue, WrappedSubject>(_ keyPath: WritableKeyPath<WrappedValue, WrappedSubject?>)
			-> Binding<WrappedSubject?> where Value == WrappedValue? {
		.init(
				get: {
					wrappedValue?[keyPath: keyPath]
				},
				set: { newValue in
					if let newValue = newValue {
						wrappedValue?[keyPath: keyPath] = newValue
					} else {
						wrappedValue = nil
					}
				}
		)
	}

}
