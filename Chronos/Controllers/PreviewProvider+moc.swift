//
//  PreviewProvider+moc.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-10-11.
//
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
