//
//  ComboBox.swift
//  Chronos
//
//  Created by Jean-Pierre Höhmann on 2023-01-18.
//
//

import Foundation
import SwiftUI


// MARK: ComboBox

struct ComboBox<CollectionType: RandomAccessCollection, Content: View, Title: View>: View
        where CollectionType.Element: Identifiable & Equatable {

    // MARK: - Life cycle methods

    init(
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content,
            @ViewBuilder label: @escaping () -> Title) {
        self._text = text
        self._selection = selection
        self.maxItems = maxItems ?? 12
        self.items = items
        self.prompt = prompt
        self.content = content
        self.label = label
    }

    init(
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            items: CollectionType,
            @ViewBuilder content: @escaping (String) -> Content,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType == [String] {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems
        ) { newValue in
            items.filter {
                $0.starts(with: newValue)
            }
        } content: {
            content($0)
        } label: {
            label()
        }
    }

    init(
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content,
            @ViewBuilder label: @escaping () -> Title) {
        self.init(
                text: text,
                selection: selection,
                prompt: Text(prompt),
                maxItems: maxItems,
                items: items,
                content: content,
                label: label)
    }

    init(
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            items: CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType == [String] {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: Text(prompt),
                maxItems: maxItems,
                items: items,
                content: content,
                label: label)
    }

    init<S: StringProtocol>(
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>,
            prompt: S,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content,
            @ViewBuilder label: @escaping () -> Title) {
        self.init(
                text: text,
                selection: selection,
                prompt: Text(prompt),
                maxItems: maxItems,
                items: items,
                content: content,
                label: label)
    }

    init<S: StringProtocol>(
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>? = nil,
            prompt: S,
            maxItems: Int? = nil,
            items: CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType == [String] {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: Text(prompt),
                maxItems: maxItems,
                items: items,
                content: content,
                label: label)
    }

    init(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content
    ) where Title == Text {
        self.init(
                text: text,
                selection: selection,
                prompt: prompt,
                maxItems: maxItems,
                items: items,
                content: content) {
            Text(title)
        }
    }

    init(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            items: CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content
    ) where CollectionType == [String], Title == Text {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items,
                content: content) {
            Text(title)
        }
    }

    init(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content
    ) where Title == Text {
        self.init(
                text: text,
                selection: selection,
                prompt: prompt,
                maxItems: maxItems,
                items: items,
                content: content) {
            Text(title)
        }
    }

    init(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            items: CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content
    ) where CollectionType == [String], Title == Text {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items,
                content: content) {
            Text(title)
        }
    }

    init<S: StringProtocol>(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>,
            prompt: S,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content
    ) where Title == Text {
        self.init(
                text: text,
                selection: selection,
                prompt: prompt,
                maxItems: maxItems,
                items: items,
                content: content) {
            Text(title)
        }
    }

    init<S: StringProtocol>(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>? = nil,
            prompt: S,
            maxItems: Int? = nil,
            items: CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content
    ) where CollectionType == [String], Title == Text {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items,
                content: content) {
            Text(title)
        }
    }

    init<S: StringProtocol>(
            _ title: S,
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content
    ) where Title == Text {
        self.init(
                text: text,
                selection: selection,
                prompt: prompt,
                maxItems: maxItems,
                items: items,
                content: content) {
            Text(title)
        }
    }

    init<S: StringProtocol>(
            _ title: S,
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            items: CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content
    ) where CollectionType == [String], Title == Text {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items,
                content: content) {
            Text(title)
        }
    }

    init<S: StringProtocol>(
            _ title: S,
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content
    ) where Title == Text {
        self.init(
                text: text,
                selection: selection,
                prompt: prompt,
                maxItems: maxItems,
                items: items,
                content: content) {
            Text(title)
        }
    }

    init<S: StringProtocol>(
            _ title: S,
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            items: CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content
    ) where CollectionType == [String], Title == Text {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items,
                content: content) {
            Text(title)
        }
    }

    init<S1: StringProtocol, S2: StringProtocol>(
            _ title: S1,
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>,
            prompt: S2,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content
    ) where Title == Text {
        self.init(
                text: text,
                selection: selection,
                prompt: prompt,
                maxItems: maxItems,
                items: items,
                content: content) {
            Text(title)
        }
    }

    init<S1: StringProtocol, S2: StringProtocol>(
            _ title: S1,
            text: Binding<String>,
            selection: Binding<CollectionType.Element?>? = nil,
            prompt: S2,
            maxItems: Int? = nil,
            items: CollectionType,
            @ViewBuilder content: @escaping (CollectionType.Element) -> Content
    ) where CollectionType == [String], Title == Text {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items,
                content: content) {
            Text(title)
        }
    }

    init(
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType,
            @ViewBuilder content: @escaping (String) -> Content,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType == [String] {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items(),
                content: content,
                label: label)
    }

    init(
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType,
            @ViewBuilder content: @escaping (String) -> Content,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType == [String] {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items(),
                content: content,
                label: label)
    }

    init<S: StringProtocol>(
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: S,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType,
            @ViewBuilder content: @escaping (String) -> Content,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType == [String] {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items(),
                content: content,
                label: label)
    }

    init(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType,
            @ViewBuilder content: @escaping (String) -> Content
    ) where CollectionType == [String], Title == Text {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items(),
                content: content)
    }

    init(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType,
            @ViewBuilder content: @escaping (String) -> Content
    ) where CollectionType == [String], Title == Text {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items(),
                content: content)
    }

    init<S: StringProtocol>(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: S,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType,
            @ViewBuilder content: @escaping (String) -> Content
    ) where CollectionType == [String], Title == Text {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items(),
                content: content)
    }

    init<S: StringProtocol>(
            _ title: S,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType,
            @ViewBuilder content: @escaping (String) -> Content
    ) where CollectionType == [String], Title == Text {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items(),
                content: content)
    }

    init<S: StringProtocol>(
            _ title: S,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType,
            @ViewBuilder content: @escaping (String) -> Content
    ) where CollectionType == [String], Title == Text {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items(),
                content: content)
    }

    init<S1: StringProtocol, S2: StringProtocol>(
            _ title: S1,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: S2,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType,
            @ViewBuilder content: @escaping (String) -> Content
    ) where CollectionType == [String], Title == Text {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items(),
                content: content)
    }

    init(
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType.Element == String, Content == Label<Text, Image> {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        } label: {
            label()
        }
    }

    init(
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            items: CollectionType,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType == [String], Content == Label<Text, Image> {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        } label: {
            label()
        }
    }

    init(
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType.Element == String, Content == Label<Text, Image> {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        } label: {
            label()
        }
    }

    init(
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            items: CollectionType,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType == [String], Content == Label<Text, Image> {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        } label: {
            label()
        }
    }

    init<S: StringProtocol>(
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: S,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType.Element == String, Content == Label<Text, Image> {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        } label: {
            label()
        }
    }

    init<S1: StringProtocol>(
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: S1,
            maxItems: Int? = nil,
            items: CollectionType,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType == [String], Content == Label<Text, Image> {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        } label: {
            label()
        }
    }

    init(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType
    ) where Title == Text, CollectionType.Element == String, Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            items: CollectionType
    ) where Title == Text, CollectionType == [String], Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType
    ) where Title == Text, CollectionType.Element == String, Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            items: CollectionType
    ) where Title == Text, CollectionType == [String], Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init<S: StringProtocol>(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: S,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType
    ) where Title == Text, CollectionType.Element == String, Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init<S: StringProtocol>(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: S,
            maxItems: Int? = nil,
            items: CollectionType
    ) where Title == Text, CollectionType == [String], Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init<S: StringProtocol>(
            _ title: S,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType
    ) where Title == Text, CollectionType.Element == String, Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init<S: StringProtocol>(
            _ title: S,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            items: CollectionType
    ) where Title == Text, CollectionType == [String], Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init<S: StringProtocol>(
            _ title: S,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType
    ) where Title == Text, CollectionType.Element == String, Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init<S: StringProtocol>(
            _ title: S,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            items: CollectionType
    ) where Title == Text, CollectionType == [String], Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init<S1: StringProtocol, S2: StringProtocol>(
            _ title: S1,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: S2,
            maxItems: Int? = nil,
            items: @escaping (String) -> CollectionType
    ) where Title == Text, CollectionType.Element == String, Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init<S1: StringProtocol, S2: StringProtocol>(
            _ title: S1,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: S2,
            maxItems: Int? = nil,
            items: CollectionType
    ) where Title == Text, CollectionType == [String], Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init(
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType == [String], Content == Label<Text, Image> {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items()) {
            Label($0, systemImage: "arrow.forward.to.line")
        } label: {
            label()
        }
    }

    init(
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType == [String], Content == Label<Text, Image> {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items()) {
            Label($0, systemImage: "arrow.forward.to.line")
        } label: {
            label()
        }
    }

    init<S: StringProtocol>(
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: S,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType,
            @ViewBuilder label: @escaping () -> Title
    ) where CollectionType == [String], Content == Label<Text, Image> {
        self.init(
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items()) {
            Label($0, systemImage: "arrow.forward.to.line")
        } label: {
            label()
        }
    }

    init(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType
    ) where CollectionType == [String], Title == Text, Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items()) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType
    ) where CollectionType == [String], Title == Text, Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items()) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init<S: StringProtocol>(
            _ title: LocalizedStringKey,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: S,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType
    ) where CollectionType == [String], Title == Text, Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items()) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init<S: StringProtocol>(
            _ title: S,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: Text? = nil,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType
    ) where CollectionType == [String], Title == Text, Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items()) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init<S: StringProtocol>(
            _ title: S,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: LocalizedStringKey,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType
    ) where CollectionType == [String], Title == Text, Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items()) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    init<S1: StringProtocol, S2: StringProtocol>(
            _ title: S1,
            text: Binding<String>,
            selection: Binding<String?>? = nil,
            prompt: S2,
            maxItems: Int? = nil,
            @ArrayBuilder<String> items: () -> CollectionType
    ) where CollectionType == [String], Title == Text, Content == Label<Text, Image> {
        self.init(
                title,
                text: text,
                selection: selection ?? Binding(text),
                prompt: prompt,
                maxItems: maxItems,
                items: items()) {
            Label($0, systemImage: "arrow.forward.to.line")
        }
    }

    // MARK: - Properties

    @Binding var text: String

    @Binding var selection: CollectionType.Element?

    let prompt: Text?

    let maxItems: Int

    var body: some View {
        TextField(text: $text, prompt: prompt, label: label)
                .popup(isPresented: isPresentingPopup) {
                    if let presentedItems {
                        VStack(alignment: .leading) {
                            ForEach(presentedItems) { item in
                                content(item)
                                        .onTapGesture {
                                            selection = item
                                            self.presentedItems = nil
                                        }
                                if item != presentedItems.last {
                                    Divider()
                                }
                            }
                        }
                                .padding()
                    }
                }
                .onChange(of: text) { newValue in
                    let newItems = items(newValue)
                    presentedItems = (!newItems.isEmpty && newItems.count <= maxItems).then(newItems)
                }
    }

    @State private var presentedItems: CollectionType?

    private var isPresentingPopup: Binding<Bool> {
        Binding(
                get: {
                    presentedItems != nil
                },
                set: { newValue in
                    presentedItems = newValue.then(items(text))
                }
        )
    }

    // MARK: - Methods

    let items: (String) -> CollectionType

    let content: (CollectionType.Element) -> Content

    let label: () -> Title

}


// MARK: ComboBox_Previews

class ComboBox_Previews: PreviewProvider {

    // MARK: - Static properties

    static var previews: some View {
        List {
            ComboBox("City", text: .constant("c"), selection: .constant(nil)) {
                "Cupertino"
                "Chicago"
                "Monaco"
                "San Francisco"
                "New York"
            }
        }
    }

}
