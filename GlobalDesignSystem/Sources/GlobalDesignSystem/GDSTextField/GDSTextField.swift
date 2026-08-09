//
//  GDSTextField.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI
import UIKit

// MARK: - GDSTextField

public struct GDSTextField: View {
    @Environment(\.gdsTheme) private var theme

    @Binding private var text: String
    @State private var isPasswordVisible = false

    private let type: GDSTextFieldType
    private let validator: GDSTextFieldValidator
    private let accessibilityIdentifier: String?

    /// Creates text field with validation behavior.
    ///
    /// - Parameters:
    ///   - type: Configuration to use. Supported values are `.email`, `.phone`, and `.password`.
    ///   - text: A binding to the current field value.
    ///   - validator: The validation rules to apply.
    ///   - accessibilityIdentifier: An optional identifier for UI testing.
    public init(
        type: GDSTextFieldType,
        text: Binding<String>,
        validator: GDSTextFieldValidator = GDSTextFieldValidator(),
        accessibilityIdentifier: String? = nil
    ) {
        self.type = type
        self._text = text
        self.validator = validator
        self.accessibilityIdentifier = accessibilityIdentifier
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            Text(type.title)
                .gdsTextStyle(theme.typography.label)
                .foregroundStyle(theme.color.textPrimary)

            HStack(spacing: theme.spacing.sm) {
                field

                if showsError {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundStyle(errorColor)
                        .accessibilityHidden(true)
                }

                if type == .password {
                    Button {
                        withAnimation(.easeOut(duration: 0.15)) {
                            isPasswordVisible.toggle()
                        }
                    } label: {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .frame(minWidth: 44, minHeight: 44)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(theme.color.linkPrimary)
                    .accessibilityIdentifier(passwordToggleAccessibilityIdentifier)
                    .accessibilityLabel(isPasswordVisible ? "Hide password" : "Show password")
                    .accessibilityHint("Toggles password visibility.")
                }
            }
            .padding(.horizontal, theme.spacing.md)
            .padding(.vertical, theme.spacing.md)
            .background(theme.color.backgroundSurface)
            .overlay {
                RoundedRectangle(cornerRadius: theme.spacing.sm, style: .continuous)
                    .stroke(showsError ? errorColor : theme.color.borderSubtle, lineWidth: showsError ? 2 : 1)
            }
            .clipShape(RoundedRectangle(cornerRadius: theme.spacing.sm, style: .continuous))

            if let errorMessage {
                Text(errorMessage)
                    .gdsTextStyle(theme.typography.label)
                    .foregroundStyle(errorColor)
            }
        }
    }

    @ViewBuilder
    private var field: some View {
        if type == .password && !isPasswordVisible {
            SecureField(type.prompt, text: $text)
                .textContentType(.password)
                .accessibilityIdentifier(accessibilityIdentifier ?? "")
                .accessibilityLabel(type.title)
                .accessibilityValue(accessibilityValue)
                .accessibilityHint(accessibilityHint)
        } else {
            TextField(type.prompt, text: fieldTextBinding)
                .textInputAutocapitalization(autocapitalization)
                .autocorrectionDisabled(true)
                .keyboardType(keyboardType)
                .textContentType(textContentType)
                .accessibilityIdentifier(accessibilityIdentifier ?? "")
                .accessibilityLabel(type.title)
                .accessibilityValue(accessibilityValue)
                .accessibilityHint(accessibilityHint)
        }
    }

    private var fieldTextBinding: Binding<String> {
        Binding(
            get: { text },
            set: { newValue in
                if type == .phone {
                    text = formatPhoneNumber(newValue)
                } else {
                    text = newValue
                }
            }
        )
    }

    private var errorMessage: String? {
        validator.message(for: type, text: text)
    }

    private var showsError: Bool {
        errorMessage != nil
    }

    private var keyboardType: UIKeyboardType {
        switch type {
        case .email:
            return .emailAddress
        case .phone:
            return .numberPad
        case .password:
            return .default
        }
    }

    private var autocapitalization: TextInputAutocapitalization {
        switch type {
        case .email, .phone, .password:
            return .never
        }
    }

    private var textContentType: UITextContentType? {
        switch type {
        case .email:
            return .emailAddress
        case .phone:
            return .telephoneNumber
        case .password:
            return .password
        }
    }

    private func formatPhoneNumber(_ value: String) -> String {
        let digits = String(validator.normalizedPhoneDigits(from: value).prefix(10))

        var result = ""

        for (index, digit) in digits.enumerated() {
            switch index {
            case 0:
                result.append("(")
                result.append(digit)
            case 2:
                result.append(digit)
                result.append(") ")
            case 5:
                result.append(digit)
                result.append("-")
            default:
                result.append(digit)
            }
        }

        return result
    }

    private var errorColor: Color {
        GDSColorPrimitives.red
    }

    private var passwordToggleAccessibilityIdentifier: String {
        guard let accessibilityIdentifier else { return "" }
        return "\(accessibilityIdentifier).visibilityToggle"
    }

    private var accessibilityValue: String {
        text.isEmpty ? "Empty" : text
    }

    private var accessibilityHint: String {
        if let errorMessage {
            return errorMessage
        }

        switch type {
        case .email:
            return "Enter an email address."
        case .phone:
            return "Enter a 10-digit phone number."
        case .password:
            return "Enter a password with at least \(validator.minimumPasswordLength) characters and a number."
        }
    }
}
