//
//  GDSTextField.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI

struct GDSTextField: View {
    @State private var secureText: String = ""
    
    var body: some View {
        SecureField(text: $secureText) {
            Text("Sample")
            // Open eye icon
        }
    }
}

#Preview {
    GDSTextField()
}
