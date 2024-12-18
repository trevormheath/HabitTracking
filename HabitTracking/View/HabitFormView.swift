//
//  HabitFormView.swift
//  HabitTracking
//
//  Created by IS 543 on 12/18/24.
//

import Foundation
import SwiftUI

struct HabitFormView: View {
    @Environment(HabitViewModel.self) private var viewModel
    @Environment(\.dismiss) var dismiss
    private var isEditMode: Bool = false
    let habitRef: Habit?
    
    @State private var formHabit: Habit = Habit(
        title: "",
        startDate: Date(),
        descr: "",
        categories: [],
        completedDates: []
    )
    
    init(inputHabit: Habit? = nil) {
        self.habitRef = inputHabit
        
        if let inputHabit {
            formHabit.title = inputHabit.title
            formHabit.startDate = inputHabit.startDate
            formHabit.descr = inputHabit.descr
            formHabit.categories = inputHabit.categories
            formHabit.completedDates = inputHabit.completedDates
            
            isEditMode = true
        }
    }
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
            NavigationStack {
                Form {
                    TextField("Name", text: $formHabit.title)
                    DatePicker("Start Date", selection: $formHabit.startDate, displayedComponents: [.date])
                    TextEditorPlus(placeholder: "Description", text: $formHabit.descr)
                    FormSection(
                        title: "Categories",
                        items: formHabit.categories,
                        onAdd: { newCategory in
                                formHabit.categories.append(newCategory)
                        }
                    )
                    //NEEDS WORK
                    FormSection(
                        title: "Completed Days",
                        items: formHabit.completedDates.map {
                            dateFormatter.string(from: $0)
                        }
                    )
                }
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            saveHabit()
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
                .navigationBarTitle("\(isEditMode ? "Edit" : "Add") Habit")
            }
        }
    
    private func saveHabit() {
        if isEditMode {
            if let habitRef {
                habitRef.title = formHabit.title
                habitRef.startDate = formHabit.startDate
                habitRef.descr = formHabit.descr
                habitRef.categories = formHabit.categories
                habitRef.completedDates = formHabit.completedDates
            }
            viewModel.refreshHabits()
        } else {
            viewModel.save(formHabit)
        }
        dismiss()
    }
}
