//
//  GDSTheme.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI

public protocol GDSTheme: Sendable {
    var color: GDSColorTokens { get }
    var spacing: GDSSpacingTokens { get }
    var typography: GDSTypographyTokens { get }
}

public struct GDSDefaultTheme: GDSTheme {
    public let color: GDSColorTokens
    public let spacing: GDSSpacingTokens
    public let typography: GDSTypographyTokens

    public init(
        color: GDSColorTokens = GDSColorTokens(
            backgroundCanvas: GDSColorPrimitives.offWhite,
            backgroundSurface: GDSColorPrimitives.white,
            backgroundAccent: GDSColorPrimitives.lightGreen,
            textPrimary: GDSColorPrimitives.black,
            textSecondary: GDSColorPrimitives.gray,
            textInverse: GDSColorPrimitives.white,
            textDisabled: GDSColorPrimitives.lightGray,
            borderSubtle: GDSColorPrimitives.lightGray,
            borderStrong: GDSColorPrimitives.blue,
            actionPrimary: GDSColorPrimitives.blue,
            actionPressed: GDSColorPrimitives.darkBlue,
            actionDisabled: GDSColorPrimitives.lightGray,
            linkPrimary: GDSColorPrimitives.blue,
            linkPressed: GDSColorPrimitives.darkBlue,
            linkDisabled: GDSColorPrimitives.gray,
            actionToggleOn: GDSColorPrimitives.green
        ),
        spacing: GDSSpacingTokens = GDSSpacingTokens(
            xs: GDSSpacingPrimitives.extraSmall,
            sm: GDSSpacingPrimitives.small,
            md: GDSSpacingPrimitives.medium,
            lg: GDSSpacingPrimitives.large,
            xl: GDSSpacingPrimitives.extraLarge,
            xxl: GDSSpacingPrimitives.extraExtraLarge
        ),
        typography: GDSTypographyTokens = GDSTypographyTokens(
            body: GDSTextStyle(
                font: .system(size: GDSTypographyPrimitives.bodyText, weight: GDSTypographyPrimitives.regular),
                lineSpacing: GDSTypographyPrimitives.bodyLineHeight - GDSTypographyPrimitives.bodyText
            ),
            label: GDSTextStyle(
                font: .system(size: GDSTypographyPrimitives.smallText, weight: GDSTypographyPrimitives.medium),
                lineSpacing: GDSTypographyPrimitives.smallLineHeight - GDSTypographyPrimitives.smallText
            ),
            action: GDSTextStyle(
                font: .system(size: GDSTypographyPrimitives.bodyText, weight: GDSTypographyPrimitives.semibold),
                lineSpacing: GDSTypographyPrimitives.bodyLineHeight - GDSTypographyPrimitives.bodyText
            ),
            title: GDSTextStyle(
                font: .system(size: GDSTypographyPrimitives.titleText, weight: GDSTypographyPrimitives.semibold),
                lineSpacing: GDSTypographyPrimitives.titleLineHeight - GDSTypographyPrimitives.titleText
            )
        )
    ) {
        self.color = color
        self.spacing = spacing
        self.typography = typography
    }
}

private struct GDSThemeKey: EnvironmentKey {
    static let defaultValue: any GDSTheme = GDSDefaultTheme()
}

public extension EnvironmentValues {
    var gdsTheme: any GDSTheme {
        get { self[GDSThemeKey.self] }
        set { self[GDSThemeKey.self] = newValue }
    }
}

public extension View {
    func gdsTheme(_ theme: any GDSTheme) -> some View {
        environment(\.gdsTheme, theme)
    }
}
