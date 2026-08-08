//
//  GDSTextFieldPreview.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI

#Preview {
    @State private var email = "hello@invalid"
    @State private var phone = "55512"
    @State private var password = "short"

    var body: some View {
        VStack(spacing: GDSDefaultTheme().spacing.lg) {
            GDSTextField(type: .email, text: $email)
            GDSTextField(type: .phone, text: $phone)
            GDSTextField(type: .password, text: $password)
        }
    }
}
