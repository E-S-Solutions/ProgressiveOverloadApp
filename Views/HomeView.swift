//
//  HomeView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: ProgressiveOverloadTracker.WorkoutSplit.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ProgressiveOverloadTracker.WorkoutSplit.creationDate, ascending: false)],
        animation: .default
    ) private var splits: FetchedResults<ProgressiveOverloadTracker.WorkoutSplit>

    var body: some View {
        NavigationView {
            List {
                ForEach(splits, id: \.self) { split in
                    NavigationLink(destination: WorkoutSplitView(split: split)) {
                        Text(split.name ?? "Unnamed Split")
                            .font(.headline)
                    }
                }
                .onDelete(perform: deleteSplits)
            }
            .navigationTitle("Workout Splits")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addSplit) {
                        Label("Add Split", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func addSplit() {
        withAnimation {
            PersistenceController.shared.addWorkoutSplit(name: "New Split")
        }
    }

    private func deleteSplits(offsets: IndexSet) {
        withAnimation {
            offsets.map { splits[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.saveContext()
        }
    }
}
