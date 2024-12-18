//
//  HabitViewModel.swift
//  HabitTracking
//
//  Created by IS 543 on 12/18/24.
//

import Foundation
import SwiftData

@Observable
class HabitViewModel {
    private var modelContext: ModelContext
    
    init(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        refreshHabits()
    }
    
    private(set) var habits: [Habit] = []
    private(set) var categories: [String] = []
    
    func habits(for category: String) -> [Habit] {
        return habits.filter {
            $0.categories.contains(category)
        }
    }
    
    func refreshHabits() {
        saveAllChanges()
        fetchHabits()
        gatherCategories()
        
        if habits.isEmpty {
            testHabits.forEach{ modelContext.insert($0) }
            refreshHabits()
        }
    }
    
    func save(_ habit: Habit) {
        modelContext.insert(habit)
        refreshHabits()
    }
    
    func deleteHabit(at index: Int) {
        modelContext.delete(habits[index])
        refreshHabits()
    }
    
    private func saveAllChanges() {
        try? modelContext.save()
    }
    
    private func fetchHabits() {
        let fetchDescriptor = FetchDescriptor<Habit>(sortBy: [SortDescriptor(\.title)])
        
        do {
            habits = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Failed to fetch habits: \(error)")
        }
    }
    
    private func gatherCategories() {
        var tempCategories = Set<String>()
        
        habits.forEach { habit in
            habit.categories.forEach { category in
                if (!tempCategories.contains(category) && category != "Exercise" && category != "Daily") {
                    tempCategories.insert(category)
                }
            }
        }
        categories = Array(tempCategories).sorted()
    }
}
