//
//  Components.swift
//  DemoApp
//
//  Created by Nithin on 2026-08-09.
//

import SwiftUI
import GlobalDesignSystem

struct ComponentsRootView: View {
    var body: some View {
        NavigationStack {
            List(ComponentCategory.allCases) { category in
                NavigationLink {
                    destination(for: category)
                } label: {
                    Label(category.title, systemImage: category.iconName)
                }
            }
            .navigationTitle("Components")
        }
    }

    @ViewBuilder
    private func destination(for category: ComponentCategory) -> some View {
        switch category {
        case .button:
            ButtonDemoView()
        case .textField:
            TextFieldDemoView()
        case .toggle:
            ToggleDemoView()
        }
    }
}

enum ComponentCategory: String, CaseIterable, Identifiable {
    case button
    case textField
    case toggle

    var id: String { rawValue }

    var title: String {
        switch self {
        case .button:
            "Button"
        case .textField:
            "TextField"
        case .toggle:
            "Toggle"
        }
    }

    var iconName: String {
        switch self {
        case .button:
            "rectangle.roundedbottom"
        case .textField:
            "character.cursor.ibeam"
        case .toggle:
            "switch.2"
        }
    }
}

struct DemoSection<Content: View>: View {
    @Environment(\.gdsTheme) private var theme

    let title: String
    let subtitle: String
    let content: Content

    init(
        title: String,
        subtitle: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.md) {
            VStack(alignment: .leading, spacing: theme.spacing.xs) {
                Text(title)
                    .gdsTextStyle(theme.typography.title)
                    .foregroundStyle(theme.color.textPrimary)

                Text(subtitle)
                    .gdsTextStyle(theme.typography.body)
                    .foregroundStyle(theme.color.textSecondary)
            }

            content
        }
    }
}
