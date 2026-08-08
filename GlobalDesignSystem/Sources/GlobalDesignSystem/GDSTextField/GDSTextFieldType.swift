//
//  GDSTextFieldType.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI

public enum GDSTextFieldType: Sendable, Equatable {
    case email
    case phone
    case password

    internal var title: String {
        switch self {
        case .email:
            return "Email"
        case .phone:
            return "Phone"
        case .password:
            return "Password"
        }
    }

    internal var prompt: String {
        switch self {
        case .email:
            return "name@example.com"
        case .phone:
            return "(555) 123-4567"
        case .password:
            return "Minimum 8 characters and 1 number"
        }
    }
}
