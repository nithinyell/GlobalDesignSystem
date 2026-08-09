//
//  GDSButtonVariantTests.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-09.
//

import Testing
@testable import GlobalDesignSystem

@Suite("Button variant resolution")
struct GDSButtonVariantTests {
    @Test("filled buttons are not underlined")
    func filledButtonsAreNotUnderlined() {
        #expect(GDSButtonVariant.filled.isUnderlined == false)
    }

    @Test("link buttons are underlined")
    func linkButtonsAreUnderlined() {
        #expect(GDSButtonVariant.link.isUnderlined == true)
    }

    @Test("link buttons resolve foreground from enabled and pressed state")
    func linkButtonsResolveForegroundFromState() {
        #expect(GDSButtonVariant.link.foregroundRole(isEnabled: true, isPressed: false) == .linkPrimary)
        #expect(GDSButtonVariant.link.foregroundRole(isEnabled: true, isPressed: true) == .linkPressed)
        #expect(GDSButtonVariant.link.foregroundRole(isEnabled: false, isPressed: false) == .linkDisabled)
    }

    @Test("link buttons have no background role")
    func linkButtonsHaveNoBackgroundRole() {
        #expect(GDSButtonVariant.link.backgroundRole(isEnabled: true, isPressed: false) == nil)
        #expect(GDSButtonVariant.link.backgroundRole(isEnabled: false, isPressed: true) == nil)
    }
}
