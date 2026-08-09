//
//  TypographyRow.swift
//  DemoApp
//
//  Created by Nithin on 2026-08-09.
//

import SwiftUI
import GlobalDesignSystem

// MARK: - TypographyToken

struct TypographyToken: Identifiable {
    let id = UUID()
    let name: String
    let sample: String
    let style: GDSTextStyle
}

// MARK: - TypographyRow

struct TypographyRow: View {
    @Environment(\.gdsTheme) private var theme

    let token: TypographyToken

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            Text(token.name)
                .gdsTextStyle(theme.typography.label)
                .foregroundStyle(theme.color.textSecondary)

            Text(token.sample)
                .gdsTextStyle(token.style)
                .foregroundStyle(theme.color.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(theme.spacing.md)
        .background(theme.color.backgroundSurface)
        .clipShape(RoundedRectangle(cornerRadius: theme.spacing.sm, style: .continuous))
    }
}
