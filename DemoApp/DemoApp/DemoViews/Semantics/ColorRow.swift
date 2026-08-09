//
//  ColorRow.swift
//  DemoApp
//
//  Created by Nithin on 2026-08-09.
//

import SwiftUI

// MARK: - ColorSwatch

struct ColorSwatch: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
}

// MARK: - ColorRow
struct ColorRow: View {
    @Environment(\.gdsTheme) private var theme

    let swatch: ColorSwatch

    var body: some View {
        HStack(spacing: theme.spacing.md) {
            RoundedRectangle(cornerRadius: theme.spacing.sm, style: .continuous)
                .fill(swatch.color)
                .frame(width: 56, height: 56)
                .overlay {
                    RoundedRectangle(cornerRadius: theme.spacing.sm, style: .continuous)
                        .stroke(theme.color.borderSubtle, lineWidth: 1)
                }

            VStack(alignment: .leading, spacing: theme.spacing.xs) {
                Text(swatch.name)
                    .gdsTextStyle(theme.typography.action)
                    .foregroundStyle(theme.color.textPrimary)

                Text("Semantic color")
                    .gdsTextStyle(theme.typography.label)
                    .foregroundStyle(theme.color.textSecondary)
            }

            Spacer()
        }
        .padding(theme.spacing.md)
        .background(theme.color.backgroundSurface)
        .clipShape(RoundedRectangle(cornerRadius: theme.spacing.sm, style: .continuous))
    }
}
