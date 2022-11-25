//
//  ManagedEntities.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-11-24.
//
//

import Foundation
import CoreData
import Combine


// MARK: ManagedEntities

/// Undocumented.
///
/// - Todo: Document.
///
@propertyWrapper
class ManagedEntities<EntityType: NSManagedObject>
        : ObservableObject, ExpressibleByNilLiteral, Identifiable, RandomAccessCollection {
    typealias Index = AnyRandomAccessCollection<EntityType>.Index
    typealias Indices = AnyRandomAccessCollection<EntityType>.Indices
    typealias Element = ManagedEntity<AnyRandomAccessCollection<EntityType>.Element>
    typealias SubSequence = ManagedEntities<AnyRandomAccessCollection<EntityType>.Element>

    // MARK: - Life cycle methods

    init(_ wrappedValue: AnyRandomAccessCollection<EntityType>? = nil) {
        if let wrappedValue = wrappedValue { self.wrappedValue = wrappedValue }
    }

    convenience init (wrappedValue: AnyRandomAccessCollection<EntityType>) {
        self.init(wrappedValue)
    }

    required convenience init(nilLiteral: ()) {
        self.init()
    }

    // MARK: - Properties

    /// Undocumented.
    ///
    /// - Todo: Document.
    ///
    var entities: AnyRandomAccessCollection<EntityType> {
        get { wrappedValue }
        set { wrappedValue = newValue }
    }

    var wrappedValue: AnyRandomAccessCollection<EntityType> {
        get {
            AnyRandomAccessCollection(_wrappedValue.filter { !$0.isFault })
        }
        set {
            self.objectWillChange.send()
            _wrappedValue = newValue
            anyCancellables.forEach { $0?.cancel() }
            anyCancellables = _wrappedValue.map { element in
                element.objectWillChange.sink { [weak self] in self?.objectWillChange.send() }
            }
        }
    }
    private var _wrappedValue: AnyRandomAccessCollection<EntityType> = AnyRandomAccessCollection<EntityType>([])

    var projectedValue: ManagedEntities<EntityType> { self }

    var indices: Indices { wrappedValue.indices }
    var startIndex: Index { wrappedValue.startIndex }
    var endIndex: Index { wrappedValue.endIndex }

    private var anyCancellables: [AnyCancellable?] = []

    // MARK: - Methods

    subscript(position: Index) -> Element { ManagedEntity<EntityType>(wrappedValue[position]) }
    subscript(bounds: Range<Index>) -> SubSequence { ManagedEntities(wrappedValue[bounds]) }

    func index(before i: Index) -> Index { wrappedValue.index(before: i) }
    func index(after i: Index) -> Index { wrappedValue.index(after: i) }

}
