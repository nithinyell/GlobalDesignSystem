//
//  ButtonUITests.swift
//  DemoApp
//
//  Created by Nithin on 2026-08-09.
//

import XCTest

final class ButtonUITests: XCTestCase {
    let helper = Helper()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    @MainActor
    func testButtonInteractions() throws {
        let app = XCUIApplication()
        app.launch()

        helper.openComponent(named: "Button", in: app)

        let primaryButton = app.buttons["demo.button.primary"]
        XCTAssertTrue(primaryButton.isEnabled)
        primaryButton.tap()
        XCTAssertTrue(
            app.staticTexts["Primary CTA tapped"].waitForExistence(timeout: 2)
        )

        let disabledButton = app.buttons["demo.button.disabled"]
        XCTAssertFalse(disabledButton.isEnabled)

        app.buttons["Link"].tap()

        let linkButton = app.buttons["demo.button.link"]
        XCTAssertTrue(linkButton.isEnabled)
        linkButton.tap()
        XCTAssertTrue(
            app.staticTexts["Link Action tapped"].waitForExistence(timeout: 2)
        )

        let disabledLinkButton = app.buttons["demo.button.linkDisabled"]
        XCTAssertFalse(disabledLinkButton.isEnabled)
    }
}
