//
//  ProgressTrackerView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//

// ProgressTrackerView.swift

import SwiftUI

// Sample Data
let sampleSplit = WorkoutSplit(
    name: "Push/Pull/Legs",
    days: [
        WorkoutDay(dayOfWeek: "Monday", exercises: [
            Exercise(name: "Bench Press", sets: 4, reps: 8, weight: 80),
            Exercise(name: "Shoulder Press", sets: 3, reps: 10, weight: 40)
        ]),
        WorkoutDay(dayOfWeek: "Tuesday", exercises: [
            Exercise(name: "Pull-Up", sets: 4, reps: 10, weight: 0),
            Exercise(name: "Deadlift", sets: 4, reps: 6, weight: 100)
        ]),
        WorkoutDay(dayOfWeek: "Wednesday", exercises: [
            Exercise(name: "Leg Press", sets: 3, reps: 12, weight: 120)
        ]),
        WorkoutDay(dayOfWeek: "Thursday", exercises: [
            Exercise(name: "Bench Press", sets: 4, reps: 8, weight: 80),
            Exercise(name: "Shoulder Press", sets: 3, reps: 10, weight: 40)
        ]),
        WorkoutDay(dayOfWeek: "Friday", exercises: [
            Exercise(name: "Pull-Up", sets: 4, reps: 10, weight: 0),
            Exercise(name: "Deadlift", sets: 4, reps: 6, weight: 100)
        ]),
        WorkoutDay(dayOfWeek: "Saturday", exercises: [
            Exercise(name: "Leg Press", sets: 3, reps: 12, weight: 120)
        ]),
        WorkoutDay(dayOfWeek: "Sunday", exercises: [
            Exercise(name: "Leg Press", sets: 3, reps: 12, weight: 120)
        ])
    ]
)


struct ProgressTrackerView: View {
    @State private var currentSplit: WorkoutSplit = sampleSplit // Sample data for now
    @State private var selectedDate = Date() // Represents the selected day in the calendar

    var body: some View {
        NavigationView {
            VStack {
                // Header displaying the split name
                Text(currentSplit.name)
                    .font(.title)
                    .bold()
                    .padding()
                
                // Calendar Week View
                CalendarWeekView(selectedDate: $selectedDate, workoutDays: currentSplit.days)
                
                Divider().padding(.vertical, 10)
                
                // Display today's workout
                if let todayWorkout = workoutForSelectedDay() {
                    TodayWorkoutView(workoutDay: todayWorkout)
                } else {
                    Text("Rest Day")
                        .font(.headline)
                        .padding()
                }
            }
            .navigationTitle("Progress Tracker")
            .padding()
        }
    }
    
    // Determine which workout to show based on the selected date
    func workoutForSelectedDay() -> WorkoutDay? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // Day of the week format
        let dayOfWeek = dateFormatter.string(from: selectedDate)
        return currentSplit.days.first { $0.dayOfWeek == dayOfWeek }
    }
}


//import SwiftUI
//import CoreData
//
//struct ProgressTrackerView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        entity: ProgressiveOverloadTracker.WorkoutSplit.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \ProgressiveOverloadTracker.WorkoutSplit.creationDate, ascending: false)],
//        animation: .default
//    ) private var splits: FetchedResults<ProgressiveOverloadTracker.WorkoutSplit>
//
//    @State private var newSplitName: String = ""
//    @State private var isShowingAddSplitAlert = false
//
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading) {
////                Text("Progress Tracker")
////                    .font(.largeTitle)
////                    .padding()
//
//                List {
//                    ForEach(splits, id: \.self) { split in
//                        NavigationLink(destination: WorkoutSplitView(split: split)) {
//                            VStack(alignment: .leading) {
//                                Text(split.name ?? "Unnamed Split")
//                                    .font(.headline)
//                                
//                                Text("Created on \(split.creationDate ?? Date(), formatter: dateFormatter)")
//                                    .font(.caption)
//                                    .foregroundColor(.gray)
//                            }
//                        }
//                    }
//                    .onDelete(perform: deleteSplits)
//                }
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button(action: {
//                            isShowingAddSplitAlert = true
//                        }) {
//                            Label("Add Split", systemImage: "plus")
//                        }
//                    }
//                }
//                .alert("New Split", isPresented: $isShowingAddSplitAlert, actions: {
//                    TextField("Enter split name", text: $newSplitName)
//                    Button("Add", action: addSplit)
//                    Button("Cancel", role: .cancel) { newSplitName = "" }
//                }, message: {
//                    Text("Please enter a name for the new workout split.")
//                })
//            }
//            .navigationTitle("Progress")
//        }
//    }
//    
//    private func addSplit() {
//        withAnimation {
//            let newSplit = ProgressiveOverloadTracker.WorkoutSplit(context: viewContext)
//            newSplit.name = newSplitName.isEmpty ? "New Split" : newSplitName
//            newSplit.creationDate = Date()
//            
//            do {
//                try viewContext.save()
//                newSplitName = "" // Clear the name after saving
//                isShowingAddSplitAlert = false // Dismiss the alert
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteSplits(at offsets: IndexSet) {
//        withAnimation {
//            offsets.map { splits[$0] }.forEach(viewContext.delete)
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
