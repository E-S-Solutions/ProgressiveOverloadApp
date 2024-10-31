//
//  AddWorkoutDayView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-30.
//

import SwiftUI

struct AddWorkoutDayView: View {
    @ObservedObject var split: WorkoutSplitEntity
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var isPresented: Bool
    @State private var dayOfWeek: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Day Details")) {
                    TextField("Day of the Week", text: $dayOfWeek)
                }
            }
            .navigationTitle("Add Workout Day")
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Save") {
                    addWorkoutDay()
                    isPresented = false
                }
            )
        }
    }

    private func addWorkoutDay() {
        let workoutDay = WorkoutDayEntity(context: viewContext)
        workoutDay.dayOfWeek = dayOfWeek
        workoutDay.split = split

        do {
            try viewContext.save()
        } catch {
            print("Failed to save workout day: \(error)")
        }
    }
}
