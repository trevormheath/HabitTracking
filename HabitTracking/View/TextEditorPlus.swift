//
//  TextEditorPlus.swift
//  HabitTracking
//
//  Created by IS 543 on 12/11/24.
//

import SwiftUI

struct TextEditorPlus: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
            if (text.isEmpty) {
                Text(placeholder)
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal, 3)
                    .padding(.vertical, 5)
                    .allowsHitTesting(false)
            }
        }
    }
}
