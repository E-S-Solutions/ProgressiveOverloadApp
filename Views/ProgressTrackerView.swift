//
//  ProgressTrackerView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//

// ProgressTrackerView.swift

import SwiftUI
import CoreData

struct ProgressTrackerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isShowingAddSplit = false
    
    @FetchRequest(
        entity: WorkoutSplitEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \WorkoutSplitEntity.creationDate, ascending: false)],
        animation: .default
    ) private var splits: FetchedResults<WorkoutSplitEntity>

    var body: some View {
        NavigationView {
            List {
                ForEach(splits, id: \.self) { split in
                    NavigationLink(destination: WorkoutSplitDetailView(split: split)) {
                        VStack(alignment: .leading) {
                            Text(split.name ?? "Unnamed Split")
                                .font(.headline)
                            Text("Created on \(split.creationDate ?? Date(), formatter: dateFormatter)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Progress Tracker")
            .navigationBarItems(trailing: Button(action: {
                isShowingAddSplit = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isShowingAddSplit) {
                AddSplitView(isPresented: $isShowingAddSplit)
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
