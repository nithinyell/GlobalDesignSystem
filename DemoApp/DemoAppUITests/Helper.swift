//
//  Helper.swift
//  DemoApp
//
//  Created by Nithin on 2026-08-09.
//

import XCTest

struct Helper {
    func openComponent(named name: String, in app: XCUIApplication) {
        app.tabBars.buttons["Components"].tap()
        app.staticTexts[name].tap()
    }
     
    func clearAndEnterText(_ text: String, in element: XCUIElement) {
        XCTAssertTrue(element.waitForExistence(timeout: 2))
        element.tap()

        let currentValue = (element.value as? String) ?? ""
        if currentValue != text && !currentValue.isEmpty && currentValue != element.label {
            element
                .typeText(
                    String(
                        repeating: XCUIKeyboardKey.delete.rawValue,
                        count: currentValue.count
                    )
                )
        }

        element.typeText(text)
    }
}
