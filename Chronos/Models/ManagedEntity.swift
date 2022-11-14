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
@propertyWrapper
class ManagedEntity<EntityType: NSManagedObject>: ObservableObject, ExpressibleByNilLiteral, Hashable, Identifiable {

    // MARK: - Class methods

    static func ==(lhs: ManagedEntity<EntityType>, rhs: ManagedEntity<EntityType>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }

    // MARK: - Life cycle methods

    init(wrappedValue: EntityType?) {
        self.wrappedValue = wrappedValue
    }

    convenience init(_ wrappedValue: EntityType?) {
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
    var entity: EntityType? {
        get { wrappedValue }
        set { wrappedValue = newValue }
    }

    var wrappedValue: EntityType? {
        get {
            _wrappedValue?.isFault.else(_wrappedValue)
        }
        set {
            self.objectWillChange.send()
            _wrappedValue = newValue
            anyCancellable?.cancel()
            anyCancellable = _wrappedValue?.objectWillChange.sink { [weak self] in
                self?.objectWillChange.send()
            }
        }
    }
    private var _wrappedValue: EntityType?

    var projectedValue: ManagedEntity<EntityType> { self }

    private var anyCancellable: AnyCancellable? = nil

    // MARK: - Methods

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    subscript<Value: NSManagedObject & Entity>(_ keyPath: WritableKeyPath<EntityType, Value?>) -> ManagedEntity<Value> {
        get { ManagedEntity<Value>(wrappedValue?[keyPath: keyPath]) }
        set { wrappedValue?[keyPath: keyPath] = newValue.wrappedValue }
    }

    func hash(into hasher: inout Hasher) {
        wrappedValue.hash(into: &hasher)
    }

}

extension ManagedEntity: Comparable where EntityType: Comparable {

    // MARK: + Comparable

    static func <(lhs: ManagedEntity<EntityType>, rhs: ManagedEntity<EntityType>) -> Bool {
        lhs.wrappedValue < rhs.wrappedValue
    }

}
