//
//  AddSplitView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-30.
//

import SwiftUI

struct AddSplitView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var isPresented: Bool
    @State private var splitName: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Split Details")) {
                    TextField("Split Name", text: $splitName)
                }
            }
            .navigationTitle("Add Split")
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Save") {
                    addSplit()
                    isPresented = false
                }
            )
        }
    }

    private func addSplit() {
        let newSplit = WorkoutSplitEntity(context: viewContext)
        newSplit.name = splitName
        newSplit.creationDate = Date()

        do {
            try viewContext.save()
        } catch {
            print("Failed to save new split: \(error)")
        }
    }
}


