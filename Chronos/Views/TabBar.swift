//
//  TabBar.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-12-05.
//
//

import Foundation
import SwiftUI


// MARK: TabBar

/// Undocumented.
///
/// - Todo: Document.
///
struct TabBar<Tab: TabBarItem>: View {

    // MARK: - Static properties

    // MARK: - Static methods

    // MARK: - Life cycle methods

    // MARK: - Properties

    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                ForEach(Tab.allCases) { tab in
                    VStack(spacing: 5) {
                        tab.image
                        tab.text.font(.caption)
                    }
                            .foregroundColor(tab == selection ? .accentColor : .primaryForeground)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .onTapGesture { selection = tab }
                }
            }
        }
                .background(Color(Asset.tabBarBackground.color))
    }

    @Binding var selection: Tab

}
