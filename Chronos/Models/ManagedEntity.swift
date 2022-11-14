//
//  ManagedEntity.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-26.
//
//

import Foundation
import CoreData
import Combine


// MARK: ManagedEntity

/// Undocumented.
///
/// - Todo: Document.
///
@propertyWrapper class ManagedEntity<Wrapped: NSManagedObject & Entity>: ObservableObject, ExpressibleByNilLiteral {

    // MARK: - Life cycle methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - wrappedValue:
    ///
    init(wrappedValue: Wrapped?) {
        self.wrappedValue = wrappedValue
    }

    /// Undocumented.
    ///
    /// - Todo: Document.
    /// - Parameters:
    ///     - wrappedValue:
    ///
    convenience init(_ wrappedValue: Wrapped?) {
        self.init(wrappedValue: wrappedValue)
    }

    required convenience init(nilLiteral: ()) {
        self.init(nil)
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var entity: Wrapped? {
        get { wrappedValue }
        set { wrappedValue = newValue }
    }

    var wrappedValue: Wrapped? {
        get {
            _wrappedValue?.primitiveId.flatMap { _ in _wrappedValue }
        }
        set {
            _wrappedValue = newValue
            anyCancellable?.cancel()
            anyCancellable = _wrappedValue?.objectWillChange.sink { [weak self] in
                self?.objectWillChange.send()
            }
        }
    }
    @Published private var _wrappedValue: Wrapped?

    var projectedValue: ManagedEntity<Wrapped> { self }

    private var anyCancellable: AnyCancellable? = nil

}
