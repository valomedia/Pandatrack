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

struct CardView<Title: View>: View {

    // MARK: - Life cycle methods

    init(
            labels: (Label<Text, Image>?, Label<Text, Image>?, Label<Text, Image>?, Label<Text, Image>?),
            @ViewBuilder title: @escaping () -> Title) {
        self.labels = labels
        self.title = title
    }

    // MARK: - Properties

    let labels: (Label<Text, Image>?, Label<Text, Image>?, Label<Text, Image>?, Label<Text, Image>?)

    var body: some View {
        VStack(alignment: .leading) {
            title().font(.headline)
            Spacer()
            HStack {
                labels.0.labelStyle(.leadingIcon)
                Spacer()
                labels.1.labelStyle(.trailingIcon)
            }.font(.caption)
            HStack {
                labels.2.labelStyle(.leadingIcon)
                Spacer()
                labels.3.labelStyle(.trailingIcon)
            }.font(.caption)
        }
                .padding()
    }

    // MARK: - Methods

    let title: () -> Title

}

// MARK: + init

extension CardView where Title == Text {

    init<S: StringProtocol>(
            title: S,
            labels: (Label<Text, Image>?, Label<Text, Image>?, Label<Text, Image>?, Label<Text, Image>?)) {
        self.init(labels: labels) {
            Text(title)
        }
    }

    init(
            title: LocalizedStringKey,
            labels: (Label<Text, Image>?, Label<Text, Image>?, Label<Text, Image>?, Label<Text, Image>?)) {
        self.init(labels: labels) {
            Text(title)
        }
    }

}


// MARK: CardView_Previews

class CardView_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        CardView(
                title: "Hello, World!",
                labels: (
                        Label("Label 1", systemImage: "1.circle.fill"),
                        Label("Label 2", systemImage: "2.circle.fill"),
                        Label("Label 3", systemImage: "3.circle.fill"),
                        Label("Label 4", systemImage: "4.circle.fill"))
        )
                .background(Theme.yellow.backgroundColor)
                .foregroundColor(Theme.yellow.foregroundColor)
                .previewLayout(.fixed(width: 400, height: 60))
    }

}
