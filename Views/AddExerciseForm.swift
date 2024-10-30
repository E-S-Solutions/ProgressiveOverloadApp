//
//  AddExerciseForm.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//

//import SwiftUI
//import CoreData
//
//struct AddExerciseForm: View {
//    @Binding var isPresented: Bool
//    var split: ProgressiveOverloadTracker.WorkoutSplit
//    var context: NSManagedObjectContext
//
//    // State properties to hold user input
//    @State private var exerciseName = ""
//    @State private var reps = ""
//    @State private var sets = ""
//    @State private var weight = ""
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Exercise Details")) {
//                    TextField("Exercise Name", text: $exerciseName)
//                    TextField("Reps", text: $reps)
//                        .keyboardType(.numberPad)
//                    TextField("Sets", text: $sets)
//                        .keyboardType(.numberPad)
//                    TextField("Weight (kg)", text: $weight)
//                        .keyboardType(.decimalPad)
//                }
//            }
//            .navigationBarTitle("Add Exercise", displayMode: .inline)
//            .navigationBarItems(
//                leading: Button("Cancel") {
//                    isPresented = false
//                },
//                trailing: Button("Save") {
//                    saveExercise()
//                    isPresented = false
//                }
//            )
//        }
//    }
//
//    private func saveExercise() {
//        guard
//            let reps = Int16(reps),
//            let sets = Int16(sets),
//            let weight = Double(weight),
//            !exerciseName.isEmpty
//        else { return }
//
//        let exercise = ExerciseEntity(context: context)
//        exercise.name = exerciseName
//        exercise.reps = reps
//        exercise.sets = sets
//        exercise.weight = weight
//        exercise.date = Date()
//        split.addToExercises(exercise)
//        
//        do {
//            try context.save()
//        } catch {
//            print("Failed to save exercise: \(error)")
//        }
//    }
//}
//
