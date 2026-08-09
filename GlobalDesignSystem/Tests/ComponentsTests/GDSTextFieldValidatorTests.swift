//
//  GDSTextFieldValidatorTests.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-09.
//

import Testing
@testable import GlobalDesignSystem

@Suite("Text field validator")
struct GDSTextFieldValidatorTests {
    @Test("returns nil message for empty string")
    func returnsNilForEmptyInput() {
        let validator = GDSTextFieldValidator(minimumPasswordLength: 12)

        #expect(validator.message(for: .email, text: "") == nil)
        #expect(validator.message(for: .phone, text: "") == nil)
        #expect(validator.message(for: .password, text: "") == nil)
    }

    @Test("returns an error message for invalid email")
    func returnsEmailValidationMessageForMalformedEmail() {
        let validator = GDSTextFieldValidator(minimumPasswordLength: 12)

        let message = validator.message(for: .email, text: "user@")

        #expect(message == "Enter a valid email address.")
    }

    @Test("valid email address")
    func acceptsValidEmailAddress() {
        let validator = GDSTextFieldValidator(minimumPasswordLength: 12)

        let message = validator.message(for: .email, text: "user@gmail.com")

        #expect(message == nil)
    }

    @Test("phone validation message when there are fewer than 10 digits")
    func returnsPhoneValidationMessageForIncompletePhoneNumber() {
        let validator = GDSTextFieldValidator()

        let message = validator.message(for: .phone, text: "(555) 123-456")

        #expect(message == "Enter a complete 10-digit phone number.")
    }

    @Test("accepts a phone number after normalizing")
    func acceptsPhoneNumberAfterNormalizingPunctuation() {
        let validator = GDSTextFieldValidator()

        let message = validator.message(for: .phone, text: "(555) 123-4567")

        #expect(message == nil)
        #expect(validator.normalizedPhoneDigits(from: "(555) 123-4567") == "5551234567")
    }

    @Test("password validation message when password does not meet policy")
    func returnsPasswordValidationMessageForWeakPassword() {
        let validator = GDSTextFieldValidator(minimumPasswordLength: 12)

        let message = validator.message(for: .password, text: "password")

        #expect(message == "Password must be at least 12 characters and include a number.")
    }

    @Test("accepts a password that meets requirements")
    func acceptsValidPassword() {
        let validator = GDSTextFieldValidator(minimumPasswordLength: 12)

        let message = validator.message(for: .password, text: "password1234")

        #expect(message == nil)
    }
}
