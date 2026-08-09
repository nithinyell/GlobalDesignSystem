//
//  GDSTogglePreview.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI

#Preview("Toggles", traits: .sizeThatFitsLayout) {
    let theme = GDSDefaultTheme()

    VStack(spacing: theme.spacing.md) {
        GDSToggleSwitch(isOn: .constant(true), title: "Enable updates")

        GDSToggleSwitch(isOn: .constant(false), title: "Disabled")
            .disabled(true)

        GDSToggleSwitch(isOn: .constant(false), title: "Notifications")
    }
    .frame(width: 320, alignment: .leading)
    .padding(24)
    .background(theme.color.backgroundCanvas)
}
