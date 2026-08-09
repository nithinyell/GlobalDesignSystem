//
//  ToggleDemoView.swift
//  DemoApp
//
//  Created by Nithin on 2026-08-09.
//

import GlobalDesignSystem
import SwiftUI

private enum ToggleDemoVariant: String, CaseIterable, Identifiable {
    case primary = "on"
    case secondary = "off"
    case disabled

    var id: String { rawValue }

    var title: String {
        switch self {
        case .primary:
            "On"
        case .secondary:
            "Off"
        case .disabled:
            "Disabled"
        }
    }

    var subtitle: String {
        switch self {
        case .primary:
            "Toggle in the on state."
        case .secondary:
            "Toggle in the off state."
        case .disabled:
            "Disabled toggle treatment."
        }
    }
}

struct ToggleDemoView: View {
    @Environment(\.gdsTheme) private var theme

    @State private var variant: ToggleDemoVariant = .primary
    @State private var primaryToggle = true
    @State private var secondaryToggle = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.xl) {
                Picker("Toggle Variant", selection: $variant) {
                    ForEach(ToggleDemoVariant.allCases) { variant in
                        Text(variant.title).tag(variant)
                    }
                }
                .pickerStyle(.segmented)

                DemoSection(title: "Toggles", subtitle: variant.subtitle) {
                    VStack(alignment: .leading, spacing: theme.spacing.md) {
                        switch variant {
                        case .primary:
                            GDSToggleSwitch(
                                isOn: $primaryToggle,
                                title: "Enable updates",
                                accessibilityIdentifier: "demo.toggle.primary"
                            )

                        case .secondary:
                            GDSToggleSwitch(
                                isOn: $secondaryToggle,
                                title: "Marketing opt-in",
                                accessibilityIdentifier: "demo.toggle.secondary"
                            )

                        case .disabled:
                            GDSToggleSwitch(
                                isOn: .constant(false),
                                title: "Disabled toggle",
                                accessibilityIdentifier: "demo.toggle.disabled"
                            )
                            .disabled(true)
                        }
                    }
                }
            }
            .padding(theme.spacing.lg)
        }
        .background(theme.color.backgroundCanvas.ignoresSafeArea())
        .navigationTitle(ComponentCategory.toggle.title)
    }
}
