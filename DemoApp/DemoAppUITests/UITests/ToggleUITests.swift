//
//  DemoAppUITests.swift
//  ToggleUITests
//
//  Created by Nithin on 2026-08-08.
//

import XCTest

final class ToggleUITests: XCTestCase {
    let helper = Helper()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
   
    @MainActor
    func testToggleStates() throws {
        let app = XCUIApplication()
        app.launch()

        helper.openComponent(named: "Toggle", in: app)

        app.buttons["On"].tap()
        let primaryToggle = app.switches["demo.toggle.primary"]
        XCTAssertEqual(primaryToggle.value as? String, "On")
        primaryToggle.tap()
        XCTAssertEqual(primaryToggle.value as? String, "Off")

        app.buttons["Off"].tap()
        let secondaryToggle = app.switches["demo.toggle.secondary"]
        XCTAssertEqual(secondaryToggle.value as? String, "Off")
        secondaryToggle.tap()
        XCTAssertEqual(secondaryToggle.value as? String, "On")

        app.buttons["Disabled"].tap()
        let disabledToggle = app.switches["demo.toggle.disabled"]
        XCTAssertEqual(disabledToggle.value as? String, "Off")
        XCTAssertFalse(disabledToggle.isEnabled)
    }
}
