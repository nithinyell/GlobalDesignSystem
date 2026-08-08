//
//  GDSToggleSwitch.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI

struct GDSToggleSwitch: View {
    @State private var toggle: Bool = false
    
    var body: some View {
        Toggle(isOn: $toggle) {
            Text("Swithc")
        }
    }
}

#Preview {
    GDSToggleSwitch()
}
