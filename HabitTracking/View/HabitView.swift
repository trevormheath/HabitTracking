//
//  HabitView.swift
//  HabitTracking
//
//  Created by IS 543 on 12/18/24.
//

import SwiftUI
import SwiftData

struct HabitView: View {
    @Environment(HabitViewModel.self) private var viewModel
    @State private var isShowingForm = false

    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink(destination: habitList(
                    for: viewModel.habits,
                    with: "All"
                )) {
                    Text("View All")
                }
                NavigationLink(destination: habitList(
                    for: viewModel.habits(for: "Daily"),
                    with: "Daily"
                )) {
                    Text("Daily Habits")
                }
                NavigationLink(destination: habitList(
                    for: viewModel.habits(for: "Exercise"),
                    with: "Exercise"
                )) {
                    Text("Exercise Habits")
                }
                ForEach(viewModel.categories, id: \.self) { category in
                    NavigationLink(destination: habitList(
                        for: viewModel.habits(for: category),
                        with: category
                    )
                    ) {
                        Text(category)
                    }
                }
                
            }
        } detail: {
            //display all habits by default
            habitList(for: viewModel.habits, with: "All")
        }
    }
    
    
    private func addItem() {
        withAnimation {
            let newItem = Habit(title: "test", startDate: Date.now, descr: "this is a test", categories: ["Work", "Test"], completedDates: [Date()])
            viewModel.save(newItem)
        }
    }

    private func deleteHabit(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                viewModel.deleteHabit(at: index)
            }
        }
    }
    
    private func enableForm() {
        withAnimation {
            isShowingForm = true
        }
    }
    
    private func habitList(for habits: [Habit], with category: String) -> some View {
        return VStack {
            Text("Today's Habits")
                .font(.headline)
            List {
                ForEach(habits) { habit in
                    HabitRow(habit: habit)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                }
                .onDelete(perform: deleteHabit)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .onTapGesture {
                            print("test")
                        }
                }
                ToolbarItem {
                    Button(action: enableForm) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingForm) {
                HabitFormView()
            }
        }
    }
}

#Preview {
    HabitView()
        .modelContainer(for: Habit.self, inMemory: true)
}
