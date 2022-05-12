//
//  CardView.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2022-07-02.
//
//

import Foundation
import SwiftUI


// MARK: CardView

/**
 - Todo: Document.
 */
struct CardView: View {

    // MARK: - Properties

    /**
     - Todo: Document.
     */
    let title: String

    /**
     - Todo: Document.
     */
    let theme: Theme

    /**
     - Todo: Document.
     */
    let labels: (
            (Label<Text, Image>, Label<Text, Image>),
            (Label<Text, Image>, Label<Text, Image>)
    )

    /**
     - Todo: Document.
     */
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.headline).accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                labels.0.0.labelStyle(.leadingIcon)
                Spacer()
                labels.0.1.labelStyle(.trailingIcon)
            }.font(.caption)
            HStack {
                labels.1.0.labelStyle(.leadingIcon)
                Spacer()
                labels.1.1.labelStyle(.trailingIcon)
            }.font(.caption)
        }
                .padding()
                .foregroundColor(theme.foregroundColor)
    }
}


// MARK: CardView_Previews

/**
 - Todo: Document.
 */
class CardView_Previews: PreviewProvider {

    // MARK: - Static properties

    /**
     - Todo: Document.
     */
    static var previews: some View {
        CardView(
                title: "Hello, World!",
                theme: .yellow,
                labels: (
                        (Label("Label 1", systemImage: "1.circle.fill"),
                                Label("Label 2", systemImage: "2.circle.fill")),
                        (Label("Label 3", systemImage: "3.circle.fill"),
                                Label("Label 4", systemImage: "4.circle.fill"))))
                .background(Theme.yellow.backgroundColor)
                .previewLayout(.fixed(width: 400, height: 60))
    }
}
