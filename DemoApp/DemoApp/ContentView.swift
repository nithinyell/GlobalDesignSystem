//
//  ContentView.swift
//  DemoApp
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI
import GlobalDesignSystem

struct ContentView: View {
    @Environment(\.gdsTheme) private var theme

    @State private var primaryToggle = true
    @State private var secondaryToggle = false
    @State private var email = "mail@domain"
    @State private var validEmail = "hello@gmail.com"
    @State private var phone = "55512"
    @State private var validPhone = "5551234567"
    @State private var password = "short"
    @State private var validPassword = "strongpass1"

    var body: some View {
        TabView {
//            Tab {
//                Text("Home")
//                    .padding(12)
//                    .background {
//                        Color.secondary
//                    }
//            } label: {
//                Label("Home", systemImage: "home")
//            }

            TokenList(
                title: "Colors",
                subtitle: "Default semantic colors",
                content: {
                    ForEach(colorSwatches) { swatch in
                        ColorRow(swatch: swatch)
                    }
                }
            )
            .tabItem {
                Label("Colors", systemImage: "paintpalette")
            }

            TokenList(
                title: "Spacing",
                subtitle: "Spacing scale used across components.",
                content: {
                    ForEach(spacingTokens) { token in
                        SpacingRow(token: token)
                    }
                }
            )
            .tabItem {
                Label("Spacing", systemImage: "ruler")
            }

            TokenList(
                title: "Typography",
                subtitle: "Text styles from the active theme.",
                content: {
                    ForEach(typographyTokens) { token in
                        TypographyRow(token: token)
                    }
                }
            )
            .tabItem {
                Label("Typography", systemImage: "textformat")
            }

            componentShowcase
                .tabItem {
                    Label("Components", systemImage: "square.grid.2x2")
                }
        }
    }

    private var componentShowcase: some View {
        return NavigationStack {
            List(ComponentCategory.allCases) { type in
                NavigationLink {
                    ComponentDetailView(
                        category: type,
                        primaryToggle: $primaryToggle,
                        secondaryToggle: $secondaryToggle,
                        email: $email,
                        validEmail: $validEmail,
                        phone: $phone,
                        validPhone: $validPhone,
                        password: $password,
                        validPassword: $validPassword
                    )
                } label: {
                    Label(type.title, systemImage: type.iconName)
                }
            }
            .navigationTitle("Components")
        }
    }

    private var colorSwatches: [ColorSwatch] {
        [
            .init(name: "backgroundCanvas", color: theme.color.backgroundCanvas),
            .init(name: "backgroundSurface", color: theme.color.backgroundSurface),
            .init(name: "backgroundAccent", color: theme.color.backgroundAccent),
            .init(name: "textPrimary", color: theme.color.textPrimary),
            .init(name: "textSecondary", color: theme.color.textSecondary),
            .init(name: "textInverse", color: theme.color.textInverse),
            .init(name: "textDisabled", color: theme.color.textDisabled),
            .init(name: "borderSubtle", color: theme.color.borderSubtle),
            .init(name: "borderStrong", color: theme.color.borderStrong),
            .init(name: "actionPrimary", color: theme.color.actionPrimary),
            .init(name: "actionPressed", color: theme.color.actionPressed),
            .init(name: "actionDisabled", color: theme.color.actionDisabled),
            .init(name: "linkPrimary", color: theme.color.linkPrimary),
            .init(name: "linkPressed", color: theme.color.linkPressed),
            .init(name: "linkDisabled", color: theme.color.linkDisabled),
            .init(name: "actionToggleOn", color: theme.color.actionToggleOn)
        ]
    }

    private var spacingTokens: [SpacingToken] {
        [
            .init(name: "xs", value: theme.spacing.xs),
            .init(name: "sm", value: theme.spacing.sm),
            .init(name: "md", value: theme.spacing.md),
            .init(name: "lg", value: theme.spacing.lg),
            .init(name: "xl", value: theme.spacing.xl),
            .init(name: "xxl", value: theme.spacing.xxl)
        ]
    }

    private var typographyTokens: [TypographyToken] {
        [
            .init(name: "body", sample: "Body text sample", style: theme.typography.body),
            .init(name: "label", sample: "Label text sample", style: theme.typography.label),
            .init(name: "action", sample: "Action text sample", style: theme.typography.action),
            .init(name: "title", sample: "Title text sample", style: theme.typography.title)
        ]
    }
}

private enum ComponentCategory: String, CaseIterable, Identifiable {
    case button
    case textField
    case toggle

    var id: String { rawValue }

    var title: String {
        switch self {
        case .button:
            return "Button"
        case .textField:
            return "TextField"
        case .toggle:
            return "Toggle"
        }
    }

    var iconName: String {
        switch self {
        case .button:
            return "rectangle.roundedbottom"
        case .textField:
            return "character.cursor.ibeam"
        case .toggle:
            return "switch.2"
        }
    }
}

private struct TokenList<Content: View>: View {
    @Environment(\.gdsTheme) private var theme

    let title: String
    let subtitle: String
    let content: Content

    init(
        title: String,
        subtitle: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.content = content()
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: theme.spacing.lg) {
                    Text(subtitle)
                        .gdsTextStyle(theme.typography.body)
                        .foregroundStyle(theme.color.textSecondary)

                    content
                }
                .padding(theme.spacing.lg)
            }
            .background(theme.color.backgroundCanvas.ignoresSafeArea())
            .navigationTitle(title)
        }
    }
}

private struct DemoSection<Content: View>: View {
    @Environment(\.gdsTheme) private var theme

    let title: String
    let subtitle: String
    let content: Content

    init(
        title: String,
        subtitle: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.md) {
            VStack(alignment: .leading, spacing: theme.spacing.xs) {
                Text(title)
                    .gdsTextStyle(theme.typography.title)
                    .foregroundStyle(theme.color.textPrimary)

                Text(subtitle)
                    .gdsTextStyle(theme.typography.body)
                    .foregroundStyle(theme.color.textSecondary)
            }

            content
        }
    }
}

private struct ComponentDetailView: View {
    @Environment(\.gdsTheme) private var theme

    let category: ComponentCategory
    @State private var buttonVariant: ButtonDemoVariant = .filled
    @State private var textFieldVariant: TextFieldDemoVariant = .email
    @State private var toggleVariant: ToggleDemoVariant = .primary
    @Binding var primaryToggle: Bool
    @Binding var secondaryToggle: Bool
    @Binding var email: String
    @Binding var validEmail: String
    @Binding var phone: String
    @Binding var validPhone: String
    @Binding var password: String
    @Binding var validPassword: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.xl) {
                variantPicker

                switch category {
                case .button:
                    buttonContent
                case .textField:
                    textFieldContent
                case .toggle:
                    toggleContent
                }
            }
            .padding(theme.spacing.lg)
        }
        .background(theme.color.backgroundCanvas.ignoresSafeArea())
        .navigationTitle(category.title)
    }

    @ViewBuilder
    private var variantPicker: some View {
        switch category {
        case .button:
            Picker("Button Variant", selection: $buttonVariant) {
                ForEach(ButtonDemoVariant.allCases) { variant in
                    Text(variant.title).tag(variant)
                }
            }
            .pickerStyle(.segmented)

        case .textField:
            Picker("TextField Variant", selection: $textFieldVariant) {
                ForEach(TextFieldDemoVariant.allCases) { variant in
                    Text(variant.title).tag(variant)
                }
            }
            .pickerStyle(.segmented)

        case .toggle:
            Picker("Toggle Variant", selection: $toggleVariant) {
                ForEach(ToggleDemoVariant.allCases) { variant in
                    Text(variant.title).tag(variant)
                }
            }
            .pickerStyle(.segmented)
        }
    }

    private var buttonContent: some View {
        DemoSection(title: "Buttons", subtitle: buttonVariant.subtitle) {
            VStack(alignment: .leading, spacing: theme.spacing.md) {
                switch buttonVariant {
                case .filled:
                    GDSButton(title: "Primary CTA", icon: Image(systemName: "arrow.right")) {
                    }

                    GDSButton(title: "Disabled CTA", icon: Image(systemName: "lock.fill")) {
                    }
                    .disabled(true)

                case .link:
                    GDSButton(variant: .link, title: "Link Action", icon: Image(systemName: "arrow.up.right")) {
                    }

                    GDSButton(variant: .link, title: "Disabled Link") {
                    }
                    .disabled(true)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    private var textFieldContent: some View {
        DemoSection(title: "Text Fields", subtitle: textFieldVariant.subtitle) {
            VStack(alignment: .leading, spacing: theme.spacing.lg) {
                switch textFieldVariant {
                case .email:
                    GDSTextField(type: .email, text: $email)
                    GDSTextField(type: .email, text: $validEmail)

                case .phone:
                    GDSTextField(type: .phone, text: $phone)
                    GDSTextField(type: .phone, text: $validPhone)

                case .password:
                    GDSTextField(type: .password, text: $password)
                    GDSTextField(type: .password, text: $validPassword)
                }
            }
        }
    }

    private var toggleContent: some View {
        DemoSection(title: "Toggles", subtitle: toggleVariant.subtitle) {
            VStack(alignment: .leading, spacing: theme.spacing.md) {
                switch toggleVariant {
                case .primary:
                    GDSToggleSwitch(isOn: $primaryToggle, title: "Enable updates")

                case .secondary:
                    GDSToggleSwitch(isOn: $secondaryToggle, title: "Marketing opt-in")

                case .disabled:
                    GDSToggleSwitch(isOn: .constant(false), title: "Disabled toggle")
                        .disabled(true)
                }
            }
        }
    }
}

private enum ButtonDemoVariant: String, CaseIterable, Identifiable {
    case filled
    case link

    var id: String { rawValue }

    var title: String { rawValue.capitalized }

    var subtitle: String {
        switch self {
        case .filled:
            return "Filled button states."
        case .link:
            return "Link-style button states."
        }
    }
}

private enum TextFieldDemoVariant: String, CaseIterable, Identifiable {
    case email
    case phone
    case password

    var id: String { rawValue }

    var title: String { rawValue.capitalized }

    var subtitle: String {
        switch self {
        case .email:
            return "Email field with invalid and valid examples."
        case .phone:
            return "Phone field with formatting and validation."
        case .password:
            return "Password field with hidden entry and validation."
        }
    }
}

private enum ToggleDemoVariant: String, CaseIterable, Identifiable {
    case primary = "on"
    case secondary = "off"
    case disabled

    var id: String { rawValue }

    var title: String {
        switch self {
        case .primary:
            return "On"
        case .secondary:
            return "Off"
        case .disabled:
            return "Disabled"
        }
    }

    var subtitle: String {
        switch self {
        case .primary:
            return "Toggle in the on state."
        case .secondary:
            return "Toggle in the off state."
        case .disabled:
            return "Disabled toggle treatment."
        }
    }
}

private struct ColorSwatch: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
}

private struct SpacingToken: Identifiable {
    let id = UUID()
    let name: String
    let value: CGFloat
}

private struct TypographyToken: Identifiable {
    let id = UUID()
    let name: String
    let sample: String
    let style: GDSTextStyle
}

private struct ColorRow: View {
    @Environment(\.gdsTheme) private var theme

    let swatch: ColorSwatch

    var body: some View {
        HStack(spacing: theme.spacing.md) {
            RoundedRectangle(cornerRadius: theme.spacing.sm, style: .continuous)
                .fill(swatch.color)
                .frame(width: 56, height: 56)
                .overlay {
                    RoundedRectangle(cornerRadius: theme.spacing.sm, style: .continuous)
                        .stroke(theme.color.borderSubtle, lineWidth: 1)
                }

            VStack(alignment: .leading, spacing: theme.spacing.xs) {
                Text(swatch.name)
                    .gdsTextStyle(theme.typography.action)
                    .foregroundStyle(theme.color.textPrimary)

                Text("Semantic color")
                    .gdsTextStyle(theme.typography.label)
                    .foregroundStyle(theme.color.textSecondary)
            }

            Spacer()
        }
        .padding(theme.spacing.md)
        .background(theme.color.backgroundSurface)
        .clipShape(RoundedRectangle(cornerRadius: theme.spacing.sm, style: .continuous))
    }
}

private struct SpacingRow: View {
    @Environment(\.gdsTheme) private var theme

    let token: SpacingToken

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            HStack {
                Text(token.name)
                    .gdsTextStyle(theme.typography.action)
                    .foregroundStyle(theme.color.textPrimary)

                Spacer()

                Text("\(Int(token.value)) pt")
                    .gdsTextStyle(theme.typography.label)
                    .foregroundStyle(theme.color.textSecondary)
            }

            RoundedRectangle(cornerRadius: theme.spacing.xs, style: .continuous)
                .fill(theme.color.actionPrimary)
                .frame(width: token.value, height: 12)
        }
        .padding(theme.spacing.md)
        .background(theme.color.backgroundSurface)
        .clipShape(RoundedRectangle(cornerRadius: theme.spacing.sm, style: .continuous))
    }
}

private struct TypographyRow: View {
    @Environment(\.gdsTheme) private var theme

    let token: TypographyToken

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            Text(token.name)
                .gdsTextStyle(theme.typography.label)
                .foregroundStyle(theme.color.textSecondary)

            Text(token.sample)
                .gdsTextStyle(token.style)
                .foregroundStyle(theme.color.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(theme.spacing.md)
        .background(theme.color.backgroundSurface)
        .clipShape(RoundedRectangle(cornerRadius: theme.spacing.sm, style: .continuous))
    }
}

#Preview {
    ContentView()
}
