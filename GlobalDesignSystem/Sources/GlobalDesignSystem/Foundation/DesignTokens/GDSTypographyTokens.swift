//
//  GDSTypographyTokens.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI

public struct GDSTextStyle: Sendable {
    public let font: Font
    public let lineSpacing: CGFloat

    public init(font: Font, lineSpacing: CGFloat) {
        self.font = font
        self.lineSpacing = lineSpacing
    }
}

public enum GDSTypographyPrimitives {
    public static let smallText: CGFloat = 14
    public static let bodyText: CGFloat = 16
    public static let titleText: CGFloat = 20

    public static let regular = Font.Weight.regular
    public static let medium = Font.Weight.medium
    public static let semibold = Font.Weight.semibold

    public static let smallLineHeight: CGFloat = 20
    public static let bodyLineHeight: CGFloat = 24
    public static let titleLineHeight: CGFloat = 28
}

public struct GDSTypographyTokens: Sendable {
    public let body: GDSTextStyle
    public let label: GDSTextStyle
    public let action: GDSTextStyle
    public let title: GDSTextStyle

    public init(
        body: GDSTextStyle,
        label: GDSTextStyle,
        action: GDSTextStyle,
        title: GDSTextStyle
    ) {
        self.body = body
        self.label = label
        self.action = action
        self.title = title
    }
}

public extension View {
    func gdsTextStyle(_ style: GDSTextStyle) -> some View {
        font(style.font)
            .lineSpacing(style.lineSpacing)
    }
}
