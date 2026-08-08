import SwiftUI

public enum GDSColorPrimitives {
    public static let blue = Color.blue
    public static let darkBlue = Color.indigo
    public static let black = Color.black
    public static let gray = Color.gray
    public static let lightGray = Color(.systemGray4)
    public static let offWhite = Color(.systemGray6)
    public static let white = Color.white
    public static let green = Color.green
    public static let lightGreen = Color.mint.opacity(0.25)
}

public struct GDSColorTokens: Sendable {
    public let backgroundCanvas: Color
    public let backgroundSurface: Color
    public let backgroundAccent: Color
    public let textPrimary: Color
    public let textSecondary: Color
    public let textInverse: Color
    public let textDisabled: Color
    public let borderSubtle: Color
    public let borderStrong: Color
    public let actionPrimary: Color
    public let actionPressed: Color
    public let actionDisabled: Color
    public let actionToggleOn: Color

    public init(
        backgroundCanvas: Color,
        backgroundSurface: Color,
        backgroundAccent: Color,
        textPrimary: Color,
        textSecondary: Color,
        textInverse: Color,
        textDisabled: Color,
        borderSubtle: Color,
        borderStrong: Color,
        actionPrimary: Color,
        actionPressed: Color,
        actionDisabled: Color,
        actionToggleOn: Color
    ) {
        self.backgroundCanvas = backgroundCanvas
        self.backgroundSurface = backgroundSurface
        self.backgroundAccent = backgroundAccent
        self.textPrimary = textPrimary
        self.textSecondary = textSecondary
        self.textInverse = textInverse
        self.textDisabled = textDisabled
        self.borderSubtle = borderSubtle
        self.borderStrong = borderStrong
        self.actionPrimary = actionPrimary
        self.actionPressed = actionPressed
        self.actionDisabled = actionDisabled
        self.actionToggleOn = actionToggleOn
    }
}
