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

    /// Creates toggle switch.
    ///
    /// - Parameters:
    ///   - isOn: A binding for on or off.
    ///   - title: The label for toggle control.
    public init(
        isOn: Binding<Bool>,
        title: String
    ) {
        self._isOn = isOn
        self.title = title
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
    }

    @ViewBuilder
    private var toggle: some View {
        if #available(iOS 26, *) {
            // In iOS 26+, adopt Liquid Glass automatically.
            baseToggle.toggleStyle(.automatic)
        } else {
            baseToggle.toggleStyle(.switch)
        }
    }
}
