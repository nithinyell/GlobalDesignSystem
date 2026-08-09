//
//  TextFieldDemoView.swift
//  DemoApp
//
//  Created by Nithin on 2026-08-09.
//

import GlobalDesignSystem
import SwiftUI

private enum TextFieldDemoVariant: String, CaseIterable, Identifiable {
    case email
    case phone
    case password

    var id: String { rawValue }

    var title: String { rawValue.capitalized }

    var subtitle: String {
        switch self {
        case .email:
            "Email field with invalid and valid examples."
        case .phone:
            "Phone field with formatting and validation."
        case .password:
            "Password field with hidden entry and validation."
        }
    }
}

struct TextFieldDemoView: View {
    @Environment(\.gdsTheme) private var theme

    @State private var variant: TextFieldDemoVariant = .email
    @State private var email = "mail@domain"
    @State private var validEmail = "hello@gmail.com"
    @State private var phone = "55512"
    @State private var validPhone = "5551234567"
    @State private var password = "short"
    @State private var validPassword = "strongpass1"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.xl) {
                Picker("TextField Variant", selection: $variant) {
                    ForEach(TextFieldDemoVariant.allCases) { variant in
                        Text(variant.title).tag(variant)
                    }
                }
                .pickerStyle(.segmented)

                DemoSection(title: "Text Fields", subtitle: variant.subtitle) {
                    VStack(alignment: .leading, spacing: theme.spacing.lg) {
                        switch variant {
                        case .email:
                            GDSTextField(type: .email, text: $email, accessibilityIdentifier: "demo.textfield.email.invalid")
                            GDSTextField(type: .email, text: $validEmail, accessibilityIdentifier: "demo.textfield.email.valid")

                        case .phone:
                            GDSTextField(type: .phone, text: $phone, accessibilityIdentifier: "demo.textfield.phone.invalid")
                            GDSTextField(type: .phone, text: $validPhone, accessibilityIdentifier: "demo.textfield.phone.valid")

                        case .password:
                            GDSTextField(type: .password, text: $password, accessibilityIdentifier: "demo.textfield.password.invalid")
                            GDSTextField(type: .password, text: $validPassword, accessibilityIdentifier: "demo.textfield.password.valid")
                        }
                    }
                }
            }
            .padding(theme.spacing.lg)
        }
        .background(theme.color.backgroundCanvas.ignoresSafeArea())
        .navigationTitle(ComponentCategory.textField.title)
    }
}
