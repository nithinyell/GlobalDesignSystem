//
//  ButtonDemoView.swift
//  DemoApp
//
//  Created by Nithin on 2026-08-09.
//

import GlobalDesignSystem
import SwiftUI

private enum ButtonDemoVariant: String, CaseIterable, Identifiable {
    case filled
    case link

    var id: String { rawValue }

    var title: String { rawValue.capitalized }

    var subtitle: String {
        switch self {
        case .filled:
            "Filled button states."
        case .link:
            "Link-style button states."
        }
    }
}

struct ButtonDemoView: View {
    @Environment(\.gdsTheme) private var theme

    @State private var variant: ButtonDemoVariant = .filled
    @State private var lastButtonActionMessage = "No button tapped yet"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.xl) {
                Picker("Button Variant", selection: $variant) {
                    ForEach(ButtonDemoVariant.allCases) { variant in
                        Text(variant.title).tag(variant)
                    }
                }
                .pickerStyle(.segmented)

                DemoSection(title: "Buttons", subtitle: variant.subtitle) {
                    VStack(alignment: .leading, spacing: theme.spacing.md) {
                        switch variant {
                        case .filled:
                            GDSButton(
                                title: "Primary CTA",
                                icon: Image(systemName: "arrow.right"),
                                accessibilityIdentifier: "demo.button.primary"
                            ) {
                                lastButtonActionMessage = "Primary CTA tapped"
                            }

                            GDSButton(
                                title: "Disabled CTA",
                                icon: Image(systemName: "lock.fill"),
                                accessibilityIdentifier: "demo.button.disabled"
                            ) {
                                lastButtonActionMessage = "Disabled CTA tapped"
                            }
                            .disabled(true)

                        case .link:
                            GDSButton(
                                variant: .link,
                                title: "Link Action",
                                icon: Image(systemName: "arrow.up.right"),
                                accessibilityIdentifier: "demo.button.link"
                            ) {
                                lastButtonActionMessage = "Link Action tapped"
                            }

                            GDSButton(
                                variant: .link,
                                title: "Disabled Link",
                                accessibilityIdentifier: "demo.button.linkDisabled"
                            ) {
                                lastButtonActionMessage = "Disabled Link tapped"
                            }
                            .disabled(true)
                        }

                        Text(lastButtonActionMessage)
                            .gdsTextStyle(theme.typography.body)
                            .foregroundStyle(theme.color.textSecondary)
                            .accessibilityIdentifier("demo.button.status")
                    }
                }
            }
           .padding(theme.spacing.lg)
        }
        .background(theme.color.backgroundCanvas.ignoresSafeArea())
        .navigationTitle(ComponentCategory.button.title)
    }
}
