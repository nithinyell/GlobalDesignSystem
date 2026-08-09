//
//  GDSToggleSwitch.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI

// MARK: - GDSToggleSwitch
public struct GDSToggleSwitch: View {
    @Environment(\.gdsTheme) private var theme

    @Binding public var isOn: Bool

    public let title: String
    public let accessibilityIdentifier: String?

    /// Creates toggle switch.
    ///
    /// - Parameters:
    ///   - isOn: A binding for on or off.
    ///   - title: The label for toggle control.
    ///   - accessibilityIdentifier: An optional identifier for UI testing.
    public init(
        isOn: Binding<Bool>,
        title: String,
        accessibilityIdentifier: String? = nil
    ) {
        self._isOn = isOn
        self.title = title
        self.accessibilityIdentifier = accessibilityIdentifier
    }

    public var body: some View {
        toggle
            .tint(theme.color.actionToggleOn)
            .padding(theme.spacing.lg)
            .background(theme.color.backgroundSurface)
            .clipShape(RoundedRectangle(cornerRadius: theme.spacing.sm, style: .continuous))
    }

    private var baseToggle: some View {
        Toggle(isOn: $isOn) {
            Text(title)
                .gdsTextStyle(theme.typography.body)
                .foregroundStyle(theme.color.textPrimary)
        }
        .accessibilityIdentifier(accessibilityIdentifier ?? "")
        .accessibilityLabel(title)
        .accessibilityValue(GDSToggleRenderState.accessibilityValue(isOn: isOn))
    }

    @ViewBuilder
    private var toggle: some View {
        if GDSToggleRenderMode.current == .automatic {
            // In iOS 26+, adopt Liquid Glass automatically.
            baseToggle.toggleStyle(.automatic)
        } else {
            baseToggle.toggleStyle(.switch)
        }
    }
}

internal enum GDSToggleRenderMode: Equatable {
    case automatic
    case legacySwitch

    static var current: GDSToggleRenderMode {
        if #available(iOS 26, *) {
            return .automatic
        } else {
            return .legacySwitch
        }
    }
}

internal enum GDSToggleRenderState {
    static func accessibilityValue(isOn: Bool) -> String {
        isOn ? "On" : "Off"
    }
}
