//
//  HabitTrackingApp.swift
//  HabitTracking
//
//  Created by IS 543 on 12/18/24.
//

import SwiftUI
import SwiftData

@main
struct HabitTrackingApp: App {
    let container: ModelContainer
    let viewModel: HabitViewModel

    var body: some Scene {
        WindowGroup {
            HabitView()
        }
        .modelContainer(container)
        .environment(viewModel)
    }
    
    init() {
        do {
            container = try ModelContainer(for: Habit.self)
        } catch {
            fatalError("""
                        Failed to create ModelContainer for Habit.
                        """)
        }
        viewModel = HabitViewModel(container.mainContext)
    }
}
