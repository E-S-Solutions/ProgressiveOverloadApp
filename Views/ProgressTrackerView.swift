//
//  ProgressTrackerView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//

import SwiftUI
import CoreData

struct ProgressTrackerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: ProgressiveOverloadTracker.WorkoutSplit.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ProgressiveOverloadTracker.WorkoutSplit.creationDate, ascending: false)],
        animation: .default
    ) private var splits: FetchedResults<ProgressiveOverloadTracker.WorkoutSplit>

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Progress Tracker")
                    .font(.largeTitle)
                    .padding()

                List {
                    ForEach(splits, id: \.self) { split in
                        NavigationLink(destination: WorkoutSplitView(split: split)) {
                            VStack(alignment: .leading) {
                                Text(split.name ?? "Unnamed Split")
                                    .font(.headline)
                                
                                Text("Created on \(split.creationDate ?? Date(), formatter: dateFormatter)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteSplits)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: addSplit) {
                            Label("Add Split", systemImage: "plus")
                        }
                    }
                }
            }
            .navigationTitle("Progress")
        }
    }
    
    private func addSplit() {
        withAnimation {
            PersistenceController.shared.addWorkoutSplit(name: "New Split")
        }
    }

    private func deleteSplits(at offsets: IndexSet) {
        withAnimation {
            offsets.map { splits[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.saveContext()
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

