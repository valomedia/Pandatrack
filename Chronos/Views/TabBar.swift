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


// MARK: TabBar_Previews

class TabBar_Previews: PreviewProvider {

    enum Tab: String, TabBarItem {
        case foo
        case bar
        case baz

        var image: Image {
            switch self {
            case .foo: return Image(systemName: "a.circle")
            case .bar: return Image(systemName: "b.circle")
            case .baz: return Image(systemName: "c.circle")
            }
        }

        var text: Text {
            Text(rawValue.capitalized)
        }

    }

    // MARK: - Static properties

    static var previews: some View {
        TabBar(selection: .constant(Tab.foo)).previewLayout(.sizeThatFits)
    }

}
