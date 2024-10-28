//
//  WorkoutSplitView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//
import SwiftUI
import CoreData

struct WorkoutSplitView: View {
    var split: ProgressiveOverloadTracker.WorkoutSplit

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var exercises: FetchedResults<ProgressiveOverloadTracker.Exercise>

    init(split: ProgressiveOverloadTracker.WorkoutSplit) {
        self.split = split
        // Initialize FetchRequest to fetch exercises associated with this workout split
        _exercises = FetchRequest(
            entity: ProgressiveOverloadTracker.Exercise.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \ProgressiveOverloadTracker.Exercise.date, ascending: true)],
            predicate: NSPredicate(format: "workoutSplit == %@", split)
        )
    }

    var body: some View {
        VStack {
            // Display workout split name and creation date
            Text(split.name ?? "Unnamed Split")
                .font(.largeTitle)
                .padding()

            Text("Creation Date: \(split.creationDate ?? Date(), formatter: dateFormatter)")
                .font(.subheadline)
                .padding()

            // List of exercises
            List {
                ForEach(exercises) { exercise in
                    VStack(alignment: .leading) {
                        Text(exercise.name ?? "Unnamed Exercise")
                            .font(.headline)
                        HStack {
                            Text("Reps: \(exercise.reps)")
                            Text("Sets: \(exercise.sets)")
                            Text("Weight: \(exercise.weight, specifier: "%.2f") kg")
                        }
                        .font(.subheadline)
                    }
                }
                .onDelete(perform: deleteExercises)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addExercise) {
                        Label("Add Exercise", systemImage: "plus")
                    }
                }
            }
        }
        .navigationTitle("Workout Split Details")
    }

    private func addExercise() {
        // Add a sample exercise to the workout split
        withAnimation {
            PersistenceController.shared.addExercise(to: split, name: "New Exercise", reps: 10, sets: 3, weight: 50.0)
        }
    }

    private func deleteExercises(at offsets: IndexSet) {
        withAnimation {
            offsets.map { exercises[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.saveContext()
        }
    }
}

// Date formatter to display dates in a user-friendly format
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()





