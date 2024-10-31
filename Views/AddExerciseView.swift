//
//  AddExerciseView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-30.
//

import SwiftUI

struct AddExerciseView: View {
    @ObservedObject var day: WorkoutDayEntity
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var isPresented: Bool
    @State private var exerciseName: String = ""
    @State private var reps: Int16 = 0
    @State private var sets: Int16 = 0
    @State private var weight: Double = 0.0

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Details")) {
                    TextField("Exercise Name", text: $exerciseName)
                    TextField("Sets", value: $sets, formatter: NumberFormatter())
                    TextField("Reps", value: $reps, formatter: NumberFormatter())
                    TextField("Weight", value: $weight, formatter: NumberFormatter())
                }
            }
            .navigationTitle("Add Exercise")
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Save") {
                    addExercise()
                    isPresented = false
                }
            )
        }
    }

    private func addExercise() {
        let exercise = ExerciseEntity(context: viewContext)
        exercise.name = exerciseName
        exercise.reps = reps
        exercise.sets = sets
        exercise.weight = weight
        exercise.workoutDay = day

        do {
            try viewContext.save()
        } catch {
            print("Failed to save exercise: \(error)")
        }
    }
}


