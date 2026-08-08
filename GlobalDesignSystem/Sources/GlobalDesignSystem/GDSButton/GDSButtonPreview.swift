//
//  GDSButtonPreview.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI

#Preview {
    VStack(spacing: GDSDefaultTheme().spacing.md) {
        GDSButton(title: "Continue", icon: Image(systemName: "arrow.right")) {
        }

        GDSButton(title: "Disabled", icon: Image(systemName: "lock.fill")) {
        }
        .disabled(true)

        GDSButton(variant: .link, title: "Learn more", icon: Image(systemName: "arrow.up.right")) {
        }

        GDSButton(variant: .link, title: "Link disabled") {
        }
        .disabled(true)
    }
    .padding(GDSDefaultTheme().spacing.lg)
    .background(GDSDefaultTheme().color.backgroundCanvas)
}
