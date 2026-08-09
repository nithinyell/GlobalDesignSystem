//
//  GDSTextFieldPreview.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI

#Preview("Text Fields", traits: .sizeThatFitsLayout) {
    let theme = GDSDefaultTheme()

    VStack(spacing: theme.spacing.lg) {
        GDSTextField(type: .email, text: .constant("hello@invalid"))
        GDSTextField(type: .phone, text: .constant("55512"))
        GDSTextField(type: .password, text: .constant("short"))
    }
    .frame(width: 320, alignment: .leading)
    .padding(24)
    .background(theme.color.backgroundCanvas)
}
