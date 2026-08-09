//
//  SpacingRow.swift
//  DemoApp
//
//  Created by Nithin on 2026-08-09.
//

import SwiftUI

// MARK: - SpacingToken

struct SpacingToken: Identifiable {
    let id = UUID()
    let name: String
    let value: CGFloat
}

// MARK: - SpacingRow

struct SpacingRow: View {
    @Environment(\.gdsTheme) private var theme

    let token: SpacingToken

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            HStack {
                Text(token.name)
                    .gdsTextStyle(theme.typography.action)
                    .foregroundStyle(theme.color.textPrimary)

                Spacer()

                Text("\(Int(token.value)) pt")
                    .gdsTextStyle(theme.typography.label)
                    .foregroundStyle(theme.color.textSecondary)
            }

            RoundedRectangle(cornerRadius: theme.spacing.xs, style: .continuous)
                .fill(theme.color.actionPrimary)
                .frame(width: token.value)
        }
        .padding(theme.spacing.md)
        .background(theme.color.backgroundSurface)
        .clipShape(RoundedRectangle(cornerRadius: theme.spacing.sm, style: .continuous))
    }
}
