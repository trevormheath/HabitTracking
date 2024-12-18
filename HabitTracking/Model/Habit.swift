//
//  Habit.swift
//  HabitTracking
//
//  Created by IS 543 on 12/18/24.
//

import Foundation
import SwiftData

@Model
final class Habit {
    var title: String
    var startDate: Date
    var endDate: Date?
    var descr: String
    var categories: [String]
    var completedDates: [Date]
    
    var streak: Int
    var completedCount: Int
    
    init(
        title: String,
        startDate: Date,
        endDate: Date? = nil,
        descr: String,
        categories: [String],
        completedDates: [Date]
    ) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.descr = descr
        self.categories = categories
        self.completedDates = completedDates
        
        self.streak = 0
        self.completedCount = 0
    }
}
