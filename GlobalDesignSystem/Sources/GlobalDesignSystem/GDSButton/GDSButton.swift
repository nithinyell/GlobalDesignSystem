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

    internal var isUnderlined: Bool {
        switch self {
        case .filled:
            false
        case .link:
            true
        }
    }

    internal func foregroundRole(isEnabled: Bool, isPressed: Bool) -> GDSThemeColorRole {
        switch self {
        case .filled:
            .textInverse
        case .link:
            if isEnabled {
                isPressed ? .linkPressed : .linkPrimary
            } else {
                .linkDisabled
            }
        }
    }

    internal func backgroundRole(isEnabled: Bool, isPressed: Bool) -> GDSThemeColorRole? {
        switch self {
        case .filled:
            if isEnabled {
                isPressed ? .actionPressed : .actionPrimary
            } else {
                .actionDisabled
            }
        case .link:
            nil
        }
    }
}

//MARK: - GDSButton
public struct GDSButton: View {
    @Environment(\.gdsTheme) private var theme

    public let variant: GDSButtonVariant
    public let title: String
    public let icon: Image?
    public let accessibilityIdentifier: String?
    public let action: () -> Void

    /// Creates a themed button.
    ///
    /// - Parameters:
    ///   - variant: Defaults to `.filled`.
    ///   - title: Button label shown to the user.
    ///   - icon: An optional leading `Image`.
    ///   - accessibilityIdentifier: An optional identifier for UI testing.
    ///   - action: The closure when the button is tapped.
    public init(
        variant: GDSButtonVariant = .filled,
        title: String,
        icon: Image? = nil,
        accessibilityIdentifier: String? = nil,
        action: @escaping () -> Void
    ) {
        self.variant = variant
        self.title = title
        self.icon = icon
        self.accessibilityIdentifier = accessibilityIdentifier
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
            .accessibilityIdentifier(accessibilityIdentifier ?? "")
        case .link:
            Button {
                action()
            } label: {
                labelView
            }
            .buttonStyle(GDSLinkButtonStyle(theme: theme))
            .accessibilityIdentifier(accessibilityIdentifier ?? "")
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
        .contentShape(Rectangle())
    }
}

private struct GDSFilledButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    let theme: any GDSTheme

    func makeBody(configuration: Configuration) -> some View {
        let foreground = GDSButtonVariant.filled.foregroundRole(isEnabled: isEnabled, isPressed: configuration.isPressed)
        let background = GDSButtonVariant.filled.backgroundRole(isEnabled: isEnabled, isPressed: configuration.isPressed)

        configuration.label
            .gdsTextStyle(theme.typography.action)
            .foregroundStyle(foreground.color(in: theme))
            .frame(minHeight: 44)
            .padding(.horizontal, theme.spacing.lg)
            .padding(.vertical, theme.spacing.md)
            .background(background?.color(in: theme))
            .clipShape(
                RoundedRectangle(
                    cornerRadius: theme.spacing.sm,
                    style: .continuous
                )
            )
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
            .animation(.easeOut(duration: 0.15), value: isEnabled)
    }
}

private struct GDSLinkButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    let theme: any GDSTheme

    func makeBody(configuration: Configuration) -> some View {
        let foreground = GDSButtonVariant.link.foregroundRole(isEnabled: isEnabled, isPressed: configuration.isPressed)

        configuration.label
            .gdsTextStyle(theme.typography.action)
            .foregroundStyle(foreground.color(in: theme))
            .underline(GDSButtonVariant.link.isUnderlined)
            .frame(minHeight: 44)
            .padding(.vertical, theme.spacing.xs)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
            .animation(.easeOut(duration: 0.15), value: isEnabled)
    }
}

internal enum GDSThemeColorRole: Equatable {
    case textInverse
    case actionPrimary
    case actionPressed
    case actionDisabled
    case linkPrimary
    case linkPressed
    case linkDisabled

    func color(in theme: any GDSTheme) -> Color {
        switch self {
        case .textInverse:
            return theme.color.textInverse
        case .actionPrimary:
            return theme.color.actionPrimary
        case .actionPressed:
            return theme.color.actionPressed
        case .actionDisabled:
            return theme.color.actionDisabled
        case .linkPrimary:
            return theme.color.linkPrimary
        case .linkPressed:
            return theme.color.linkPressed
        case .linkDisabled:
            return theme.color.linkDisabled
        }
    }
}
