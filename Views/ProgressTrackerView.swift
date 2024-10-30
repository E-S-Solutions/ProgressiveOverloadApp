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

    @State private var newSplitName: String = ""
    @State private var isShowingAddSplitAlert = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
//                Text("Progress Tracker")
//                    .font(.largeTitle)
//                    .padding()

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
                        Button(action: {
                            isShowingAddSplitAlert = true
                        }) {
                            Label("Add Split", systemImage: "plus")
                        }
                    }
                }
                .alert("New Split", isPresented: $isShowingAddSplitAlert, actions: {
                    TextField("Enter split name", text: $newSplitName)
                    Button("Add", action: addSplit)
                    Button("Cancel", role: .cancel) { newSplitName = "" }
                }, message: {
                    Text("Please enter a name for the new workout split.")
                })
            }
            .navigationTitle("Progress")
        }
    }
    
    private func addSplit() {
        withAnimation {
            let newSplit = ProgressiveOverloadTracker.WorkoutSplit(context: viewContext)
            newSplit.name = newSplitName.isEmpty ? "New Split" : newSplitName
            newSplit.creationDate = Date()
            
            do {
                try viewContext.save()
                newSplitName = "" // Clear the name after saving
                isShowingAddSplitAlert = false // Dismiss the alert
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
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
