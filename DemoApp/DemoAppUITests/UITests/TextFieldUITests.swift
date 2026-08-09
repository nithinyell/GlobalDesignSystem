//
//  TextFieldTests.swift
//  DemoApp
//
//  Created by Nithin on 2026-08-09.
//

import XCTest

final class TextFieldUITests: XCTestCase {
    let helper = Helper()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testTextFieldValidationStates() throws {
        let app = XCUIApplication()
        app.launch()

        helper.openComponent(named: "TextField", in: app)

        app.buttons["Email"].tap()
        let invalidEmailField = app.textFields["demo.textfield.email.invalid"]
        helper.clearAndEnterText("name@", in: invalidEmailField)
        XCTAssertTrue(
            app
                .staticTexts["Enter a valid email address."]
                .waitForExistence(timeout: 2)
        )

        app.buttons["Phone"].tap()
        let invalidPhoneField = app.textFields["demo.textfield.phone.invalid"]
        helper.clearAndEnterText("555123456", in: invalidPhoneField)
        XCTAssertTrue(
            app
                .staticTexts["Enter a complete 10-digit phone number."]
                .waitForExistence(timeout: 2)
        )

        app.buttons["Password"].tap()
        let invalidPasswordField = app.secureTextFields["demo.textfield.password.invalid"]
        helper.clearAndEnterText("short", in: invalidPasswordField)
        XCTAssertTrue(
            app
                .staticTexts["Password must be at least 8 characters and include a number."]
                .waitForExistence(timeout: 2)
        )
    }
}
