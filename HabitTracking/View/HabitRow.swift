//
//  HabitBox.swift
//  HabitTracking
//
//  Created by IS 543 on 12/18/24.
//

import SwiftUI

struct HabitRow: View {
    let habit: Habit
    @Environment(\.editMode) private var editMode
    @State private var viewingForm = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(habit.title)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 16) {
                Button(action: toggleCompletion) {
                    Image(systemName: isCompletedToday ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(isCompletedToday ? .green : .gray)
                        .animation(.spring(), value: isCompletedToday)
                }
                //NEEDS WORK (prevent collisions)
                if (editMode?.wrappedValue == .active) {
                    Button(action: {
                        viewingForm = true
                    }) {
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
        .sheet(isPresented: $viewingForm) {
            HabitFormView(inputHabit: habit)
        }
    }
    
    private func toggleCompletion() {
        let calendar = Calendar.current
        let today = Date()
        if isCompletedToday {
            habit.completedDates.removeAll { date in
                calendar.isDate(date, inSameDayAs: today)
            }
        } else {
            habit.completedDates.append(today)
        }
    }
    
    private var isCompletedToday: Bool {
        let today = Date()
        return habit.completedDates.contains {
            Calendar.current.isDate($0, inSameDayAs: today)
        }
    }
}
