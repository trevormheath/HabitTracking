//
//  FormSection.swift
//  HabitTracking
//
//  Created by IS 543 on 12/18/24.
//

import SwiftUI

struct FormSection: View {
    let title: String
    let items: [String]
    var onAdd: ((String) -> Void)? = nil
    
    @State private var newItemText = ""
    @State private var isAddingNew = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.secondary.opacity(0.1))
                            )
                            .foregroundColor(.primary)
                    }
                    if let onAdd = onAdd {
                        if isAddingNew {
                            TextField("New item", text: $newItemText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 120)
                                .onSubmit {
                                    if !newItemText.isEmpty {
                                        onAdd(newItemText)
                                        newItemText = ""
                                        isAddingNew = false
                                    }
                                }
                        } else {
                            Button(action: {
                                isAddingNew = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.title2)
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}
