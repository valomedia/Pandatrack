//
//  Binding+map.swift
//  Chronos
//

import Foundation
import SwiftUI


// MARK: Binding

extension Binding {

    // MARK: + map

    func map<Subject>(
		get: @escaping (Value) -> Subject,
		set: @escaping (inout Value, Subject) -> Void
	) -> Binding<Subject> {
		.init(
			get: { get(wrappedValue) },
			set: { set(&wrappedValue, $0) }
		)
	}

}
