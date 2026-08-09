//
//  GDSButtonPreview.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI

#Preview("Buttons", traits: .sizeThatFitsLayout) {
    let theme = GDSDefaultTheme()

    VStack(spacing: theme.spacing.md) {
        GDSButton(title: "Continue", icon: Image(systemName: "chevron.right.2")) {
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
    .frame(width: 320, alignment: .center)
    .padding(24)
    .background(theme.color.backgroundCanvas)
}
