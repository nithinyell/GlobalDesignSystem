//
//  GDSTogglePreview.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

#Preview {
    @State private var enabled = true
    @State private var notifications = false

    var body: some View {
        VStack(spacing: GDSDefaultTheme().spacing.md) {
            GDSToggleSwitch(isOn: $enabled, title: "Enable updates")

            GDSToggleSwitch(isOn: .constant(false), title: "Disabled")
                .disabled(true)

            GDSToggleSwitch(isOn: $notifications, title: "Notifications")
        }
        .padding(GDSDefaultTheme().spacing.lg)
        .background(GDSDefaultTheme().color.backgroundCanvas)
    }
}
