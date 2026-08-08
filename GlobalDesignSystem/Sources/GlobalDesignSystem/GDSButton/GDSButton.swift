//
//  GDSButton.swift
//  GlobalDesignSystem
//
//  Created by Nithin on 2026-08-08.
//

import SwiftUI

struct GDSButton: View {
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Text("Button")
        }

    }
}

#Preview {
    GDSButton {
        
    }
}
