//
//  MissingFeatureView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-07.
//
//

import Foundation
import SwiftUI


// MARK: MissingFeatureView

/// Undocumented.
///
/// - Todo: Document.
///
struct MissingFeatureView: View {

    // MARK: - Properties

    var body: some View {
        NoContentView(
                title: "Under Construction",
                headline: "You have stumbled upon a feature we are still working on",
                caption: """
                         Ok, there is good news and bad news.  The bad news is, there is absolutely nothing you can \
                         do or see here.  Whatever you came to try just isn't finished yet.  The good news is, that \
                         there is nothing you need to do either.  We are already working on this and it will be ready \
                         for you soon-ish.

                         So sit back.  Relax.  Get comfortable.  Have a drink.  And enjoy the feeling of having \
                         someone else do all the hard work for you.  Or not.  I won't tell you how to live your life.
                         """)
    }

}


// MARK: MissingFeatureView_Previews

class MissingFeatureView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        MissingFeatureView()
    }

}