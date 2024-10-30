//
//  TodayWorkoutView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-30.
//

// TodayWorkoutView.swift

import SwiftUI

struct TodayWorkoutView: View {
    var workoutDay: WorkoutDay

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(workoutDay.dayOfWeek)'s Workout")
                .font(.headline)
                .padding(.bottom, 5)

            ForEach(workoutDay.exercises) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name)
                        .font(.subheadline)
                        .bold()
                    
                    Text("Sets: \(exercise.sets) • Reps: \(exercise.reps) • Weight: \(exercise.weight, specifier: "%.1f") kg")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 5)
                }
                .padding(.vertical, 5)
                Divider()
            }
        }
        .padding()
    }
}
