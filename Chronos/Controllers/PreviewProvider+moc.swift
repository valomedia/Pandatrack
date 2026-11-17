//
//  PreviewProvider+moc.swift
//  Chronos
//

import Foundation
import SwiftUI
import CoreData


// MARK: PreviewProvider

extension PreviewProvider {

    // MARK: + moc

    static var moc: NSManagedObjectContext {
        PersistenceController.preview!.container.viewContext
    }

}
