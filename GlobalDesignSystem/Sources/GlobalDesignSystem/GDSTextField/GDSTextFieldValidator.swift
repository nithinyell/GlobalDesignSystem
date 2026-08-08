//
//  GDSTextFieldValidator.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI

public struct GDSTextFieldValidator: Sendable {
    public let minimumPasswordLength: Int

    public init(minimumPasswordLength: Int = 8) {
        self.minimumPasswordLength = minimumPasswordLength
    }

    public func message(for type: GDSTextFieldType, text: String) -> String? {
        guard !text.isEmpty else { return nil }

        switch type {
        case .email:
            return isValidEmail(text) ? nil : "Enter a valid email address."
        case .phone:
            return normalizedPhoneDigits(from: text).count == 10 ? nil : "Enter a complete 10-digit phone number."
        case .password:
            return isValidPassword(text) ? nil : "Password must be at least \(minimumPasswordLength) characters and include a number."
        }
    }

    private func isValidEmail(_ text: String) -> Bool {
        let pattern = #"^[A-Z0-9a-z._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        return text.range(of: pattern, options: .regularExpression) != nil
    }

    private func isValidPassword(_ text: String) -> Bool {
        text.count >= minimumPasswordLength && text.contains(where: \.isNumber)
    }

    func normalizedPhoneDigits(from text: String) -> String {
        text.filter(\.isNumber)
    }
}
