//
//  GDSButton.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI

/// Visual styles  ``GDSButton``.
public enum GDSButtonVariant: Sendable {
    case filled
    case link
}

//MARK: - GDSButton
public struct GDSButton: View {
    @Environment(\.gdsTheme) private var theme

    public let variant: GDSButtonVariant
    public let title: String
    public let icon: Image?
    public let action: () -> Void

    /// Creates a themed button.
    ///
    /// - Parameters:
    ///   - variant: Defaults to `.filled`.
    ///   - title: Button label shown to the user.
    ///   - icon: An optional leading `Image`.
    ///   - action: The closure when the button is tapped.
    public init(
        variant: GDSButtonVariant = .filled,
        title: String,
        icon: Image? = nil,
        action: @escaping () -> Void
    ) {
        self.variant = variant
        self.title = title
        self.icon = icon
        self.action = action
    }

    public var body: some View {
        switch variant {
        case .filled:
            Button {
                action()
            } label: {
                labelView
            }
            .buttonStyle(GDSFilledButtonStyle(theme: theme))
        case .link:
            Button {
                action()
            } label: {
                labelView
            }
            .buttonStyle(GDSLinkButtonStyle(theme: theme))
        }
    }

    @ViewBuilder
    private var labelView: some View {
        HStack(spacing: theme.spacing.sm) {
            if let icon {
                icon
                    .imageScale(.medium)
            }

            Text(title)
                .lineLimit(1)
        }
    }
}

private struct GDSFilledButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    let theme: any GDSTheme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .gdsTextStyle(theme.typography.action)
            .foregroundStyle(theme.color.textInverse)
            .padding(.horizontal, theme.spacing.lg)
            .padding(.vertical, theme.spacing.md)
            .background(backgroundColor(for: configuration))
            .clipShape(
                RoundedRectangle(
                    cornerRadius: theme.spacing.sm,
                    style: .continuous
                )
            )
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
            .animation(.easeOut(duration: 0.15), value: isEnabled)
    }

    private func backgroundColor(for configuration: Configuration) -> Color {
        guard isEnabled else { return theme.color.actionDisabled }
        return configuration.isPressed ? theme.color.actionPressed : theme.color.actionPrimary
    }
}

private struct GDSLinkButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    let theme: any GDSTheme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .gdsTextStyle(theme.typography.action)
            .foregroundStyle(foregroundColor(for: configuration))
            .underline()
            .padding(.vertical, theme.spacing.xs)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
            .animation(.easeOut(duration: 0.15), value: isEnabled)
    }

    private func foregroundColor(for configuration: Configuration) -> Color {
        guard isEnabled else { return theme.color.linkDisabled }
        return configuration.isPressed ? theme.color.linkPressed : theme.color.linkPrimary
    }
}
