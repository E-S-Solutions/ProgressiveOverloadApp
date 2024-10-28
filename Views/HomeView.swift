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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Branding/Introduction Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome to Overload Pro")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("accentColor"))
                    
                    Text("Your personal fitness portfolio and tracker for progressive overload.")
                        .font(.subheadline)
                        .foregroundColor(Color("primaryText"))
                }
                .padding()
                .background(Color("primaryBackground"))
                .cornerRadius(12)
                .padding([.top, .horizontal])
                
                // Articles Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Articles")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("accentColor"))
                    
                    ForEach(0..<3) { _ in
                        // Placeholder for articles - replace with actual article data when available
                        Text("Sample Article Title")
                            .font(.headline)
                            .foregroundColor(Color("primaryText"))
                    }
                    
                    NavigationLink(destination: ArticlesView()) {
                        Text("View All Articles")
                            .font(.subheadline)
                            .foregroundColor(Color("accentColor"))
                    }
                }
                .padding()
                .background(Color("primaryBackground"))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Progress Tracker Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Progress Tracker")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("accentColor"))
                    
                    ForEach(splits, id: \.self) { split in
                        NavigationLink(destination: WorkoutSplitView(split: split)) {
                            VStack(alignment: .leading) {
                                Text(split.name ?? "Unnamed Split")
                                    .font(.headline)
                                    .foregroundColor(Color("primaryText"))
                                
                                Text("Created on \(split.creationDate ?? Date(), formatter: dateFormatter)")
                                    .font(.caption)
                                    .foregroundColor(Color.gray)
                            }
                        }
                        .padding()
                        .background(Color("secondaryBackground"))
                        .cornerRadius(8)
                    }
                    
                    Button(action: addSplit) {
                        Label("Add New Workout Split", systemImage: "plus")
                            .foregroundColor(Color("accentColor"))
                    }
                    .padding(.top)
                }
                .padding()
                .background(Color("primaryBackground"))
                .cornerRadius(12)
                .padding(.horizontal)
            }
        }
        .background(Color("background").ignoresSafeArea())
        .navigationTitle("Home")
    }

    private func addSplit() {
        withAnimation {
            PersistenceController.shared.addWorkoutSplit(name: "New Split")
        }
    }
}

// Date formatter for displaying dates in a user-friendly format
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
