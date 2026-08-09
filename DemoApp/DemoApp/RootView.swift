//
//  RootView.swift
//  DemoApp
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI
import GlobalDesignSystem

struct RootView: View {
    @Environment(\.gdsTheme) private var theme

    var body: some View {
        TabView {
            TokenList(
                title: "Colors",
                subtitle: "Default semantic colors",
                content: {
                    ForEach(colorSwatches) { swatch in
                        ColorRow(swatch: swatch)
                    }
                }
            )
            .tabItem {
                Label("Colors", systemImage: "paintpalette")
            }

            TokenList(
                title: "Spacing",
                subtitle: "Spacing scale.",
                content: {
                    ForEach(spacingTokens) { token in
                        SpacingRow(token: token)
                    }
                }
            )
            .tabItem {
                Label("Spacing", systemImage: "ruler")
            }

            TokenList(
                title: "Typography",
                subtitle: "Text styles from theme.",
                content: {
                    ForEach(typographyTokens) { token in
                        TypographyRow(token: token)
                    }
                }
            )
            .tabItem {
                Label("Typography", systemImage: "textformat.size")
            }

            ComponentsRootView()
                .tabItem {
                    Label("Components", systemImage: "square.grid.2x2")
                }
        }
    }

    private var colorSwatches: [ColorSwatch] {
        [
            .init(name: "backgroundCanvas", color: theme.color.backgroundCanvas),
            .init(name: "backgroundSurface", color: theme.color.backgroundSurface),
            .init(name: "backgroundAccent", color: theme.color.backgroundAccent),
            .init(name: "textPrimary", color: theme.color.textPrimary),
            .init(name: "textSecondary", color: theme.color.textSecondary),
            .init(name: "textInverse", color: theme.color.textInverse),
            .init(name: "textDisabled", color: theme.color.textDisabled),
            .init(name: "borderSubtle", color: theme.color.borderSubtle),
            .init(name: "borderStrong", color: theme.color.borderStrong),
            .init(name: "actionPrimary", color: theme.color.actionPrimary),
            .init(name: "actionPressed", color: theme.color.actionPressed),
            .init(name: "actionDisabled", color: theme.color.actionDisabled),
            .init(name: "linkPrimary", color: theme.color.linkPrimary),
            .init(name: "linkPressed", color: theme.color.linkPressed),
            .init(name: "linkDisabled", color: theme.color.linkDisabled),
            .init(name: "actionToggleOn", color: theme.color.actionToggleOn)
        ]
    }

    private var spacingTokens: [SpacingToken] {
        [
            .init(name: "xs", value: theme.spacing.xs),
            .init(name: "sm", value: theme.spacing.sm),
            .init(name: "md", value: theme.spacing.md),
            .init(name: "lg", value: theme.spacing.lg),
            .init(name: "xl", value: theme.spacing.xl),
            .init(name: "xxl", value: theme.spacing.xxl)
        ]
    }

    private var typographyTokens: [TypographyToken] {
        [
            .init(name: "body", sample: "Body text sample", style: theme.typography.body),
            .init(name: "label", sample: "Label text sample", style: theme.typography.label),
            .init(name: "action", sample: "Action text sample", style: theme.typography.action),
            .init(name: "title", sample: "Title text sample", style: theme.typography.title)
        ]
    }
}

private struct TokenList<Content: View>: View {
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
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: theme.spacing.lg) {
                    Text(subtitle)
                        .gdsTextStyle(theme.typography.body)
                        .foregroundStyle(theme.color.textSecondary)

                    content
                }
                .padding(theme.spacing.lg)
            }
            .background(theme.color.backgroundCanvas.ignoresSafeArea())
            .navigationTitle(title)
        }
    }
}
