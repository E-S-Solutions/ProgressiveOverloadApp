//
//  WorkoutSplit.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-30.
//

// WorkoutSplit.swift

import Foundation

// Represents a workout split that the user follows (e.g., Push/Pull/Legs)
struct WorkoutSplit: Identifiable {
    let id = UUID()
    var name: String
    var days: [WorkoutDay]
}

// Represents a day in the split with multiple exercises
struct WorkoutDay: Identifiable {
    let id = UUID()
    var dayOfWeek: String // e.g., "Monday"
    var exercises: [Exercise]
}

// Represents an exercise in a workout day
struct Exercise: Identifiable {
    let id = UUID()
    var name: String
    var sets: Int
    var reps: Int
    var weight: Double
}

