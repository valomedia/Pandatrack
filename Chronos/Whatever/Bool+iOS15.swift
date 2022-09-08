//
//  Bool+iOS15.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-09-08.
//
//

import Foundation


// MARK: Bool

// MARK: + iOS15

extension Bool {

    // MARK: - Static properties

    /// Whether this is running in iOS 15 or above.
    ///
    /// This predicate checks whether the operating system code is running is at least iOS 15 (or macCatalyst 15).
    ///
    /// - Todo: Document.
    ///
    static var iOS15: Bool {
        if #available(iOS 15, macCatalyst 15, *) {
            // Return true if the code is running on iOS 15 (or MacCatalyst 15) or higher. In theory this code path
            // will also be reached if the code is running on any other operating system, regardless of operating system
            // version. The only thing preventing that case from happening is the lack of a build target for any other
            // platform. This is somewhat ugly, since somebody adding a target needs to remember to go in and update all
            // availability checks, but there is no other option, since for some reason availability checks will always
            // treat unknown platforms as satisfying the constraint. It is not possible to work around this by using
            // `#unavailable`, since that always yields the inverse result of `#available`, even though the
            // documentation is unclear on this. This behavior makes it fundamentally impossible to distinguish between
            // systems that satisfy the constraint and systems that simply didn't exist at the time the constraint was
            // written, which is *never* useful and *always* the exact opposite of what is intended. It is ridiculous!
            // I don't know who thought this was a good idea. I don't understand how we got to this place. I don't
            // understand why no-one else seems bothered by this. Is everyone mad? Am I mad? I don't know. I hope to
            // find out some day.
            return true
        } else {
            // Return false if the code is running on iOS below 15 or MacCatalyst below 15.
            return false
        }
    }
}
