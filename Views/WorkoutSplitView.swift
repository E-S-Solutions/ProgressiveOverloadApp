//
//  WorkoutSplitView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//
//import SwiftUI
//import CoreData
//
//struct WorkoutSplitView: View {
//    var split: ProgressiveOverloadTracker.WorkoutSplit
//
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest var exercises: FetchedResults<ProgressiveOverloadTracker.ExerciseEntity>
//
//    // State variables for modal form
//    @State private var showAddExerciseForm = false
//    @State private var exerciseName = ""
//    @State private var reps = ""
//    @State private var sets = ""
//    @State private var weight = ""
//
//    init(split: ProgressiveOverloadTracker.WorkoutSplit) {
//        self.split = split
//        _exercises = FetchRequest(
//            entity: ProgressiveOverloadTracker.ExerciseEntity.entity(),
//            sortDescriptors: [NSSortDescriptor(keyPath: \ProgressiveOverloadTracker.ExerciseEntity.date, ascending: true)],
//            predicate: NSPredicate(format: "workoutSplitEntity == %@", split)
//        )
//    }
//
//    var body: some View {
//        VStack {
//            Text(split.name ?? "Unnamed Split")
//                .font(.largeTitle)
//                .padding()
//
//            Text("Creation Date: \(split.creationDate ?? Date(), formatter: dateFormatter)")
//                .font(.subheadline)
//                .padding()
//
//            List {
//                ForEach(exercises) { exercise in
//                    VStack(alignment: .leading) {
//                        Text(exercise.name ?? "Unnamed Exercise")
//                            .font(.headline)
//                        HStack {
//                            Text("Reps: \(exercise.reps)")
//                            Text("Sets: \(exercise.sets)")
//                            Text("Weight: \(exercise.weight, specifier: "%.2f") kg")
//                        }
//                        .font(.subheadline)
//                    }
//                }
//                .onDelete(perform: deleteExercises)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        showAddExerciseForm.toggle()
//                    }) {
//                        Label("Add Exercise", systemImage: "plus")
//                    }
//                }
//            }
//            .sheet(isPresented: $showAddExerciseForm) {
//                AddExerciseForm(
//                    isPresented: $showAddExerciseForm,
//                    split: split,
//                    context: viewContext
//                )
//            }
//        }
//        .navigationTitle("Workout Split Details")
//    }
//
//    private func deleteExercises(at offsets: IndexSet) {
//        withAnimation {
//            offsets.map { exercises[$0] }.forEach(viewContext.delete)
//            PersistenceController.shared.saveContext()
//        }
//    }
//}
//
//private let dateFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .medium
//    return formatter
//}()
//
//




