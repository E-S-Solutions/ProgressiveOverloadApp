//
//  WorkoutDayDetailView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-30.
//

import SwiftUI

struct WorkoutDayDetailView: View {
    @ObservedObject var day: WorkoutDayEntity
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isShowingAddExercise = false

    var body: some View {
        VStack {
            Text(day.dayOfWeek ?? "Unknown Day")
                .font(.title)
                .padding()

            List {
                ForEach(day.exercisesArray, id: \.self) { exercise in
                    VStack(alignment: .leading) {
                        Text(exercise.name ?? "Unknown Exercise")
                            .font(.headline)
                        Text("Sets: \(exercise.sets) • Reps: \(exercise.reps) • Weight: \(exercise.weight) kg")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Workout Day")
            .navigationBarItems(trailing: Button(action: {
                isShowingAddExercise = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isShowingAddExercise) {
                AddExerciseView(day: day, isPresented: $isShowingAddExercise)
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}

extension WorkoutDayEntity {
    // Helper to convert exercises to an array
    var exercisesArray: [ExerciseEntity] {
        let set = exercises as? Set<ExerciseEntity> ?? []
        return set.sorted { $0.name ?? "" < $1.name ?? "" }
    }
}



