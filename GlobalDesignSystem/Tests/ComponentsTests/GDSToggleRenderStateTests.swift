//
//  GDSToggleRenderStateTests.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-09.
//

import Testing
@testable import GlobalDesignSystem

@Suite("Toggle render state")
struct GDSToggleRenderStateTests {
    @Test("accessibility value for off state")
    func accessibilityValueReflectsOffState() {
        #expect(GDSToggleRenderState.accessibilityValue(isOn: false) == "Off")
    }

    @Test("accessibility value for on state")
    func accessibilityValueReflectsOnState() {
        #expect(GDSToggleRenderState.accessibilityValue(isOn: true) == "On")
    }

    @Test("platform availability")
    func currentRenderModeMatchesPlatformAvailability() {
        if #available(iOS 26, *) {
            #expect(GDSToggleRenderMode.current == .automatic)
        } else {
            #expect(GDSToggleRenderMode.current == .legacySwitch)
        }
    }
}

