//
//  WorkoutSplitDetailView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-30.
//

import SwiftUI

struct WorkoutSplitDetailView: View {
    @ObservedObject var split: WorkoutSplitEntity
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isShowingAddDay = false

    var body: some View {
        VStack {
            Text(split.name ?? "Unnamed Split")
                .font(.title)
                .padding()

            List {
                // Convert workoutDays to an array and sort if needed
                ForEach(split.workoutDaysArray, id: \.self) { day in
                    NavigationLink(destination: WorkoutDayDetailView(day: day)) {
                        Text(day.dayOfWeek ?? "Unknown Day")
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("Split Details")
            .navigationBarItems(trailing: Button(action: {
                isShowingAddDay = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isShowingAddDay) {
                AddWorkoutDayView(split: split, isPresented: $isShowingAddDay)
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}

extension WorkoutSplitEntity {
    // Helper to convert workoutDays to an array
    var workoutDaysArray: [WorkoutDayEntity] {
        let set = workoutDays as? Set<WorkoutDayEntity> ?? []
        return set.sorted { $0.dayOfWeek ?? "" < $1.dayOfWeek ?? "" }
    }
}
