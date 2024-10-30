////
////  HomeView.swift
////  ProgressiveOverloadTracker
////
////  Created by Suleyman Kiani on 2024-10-28.
////
//
//import SwiftUI
//import CoreData
//
//struct HomeView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        entity: ProgressiveOverloadTracker.WorkoutSplit.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \ProgressiveOverloadTracker.WorkoutSplit.creationDate, ascending: false)],
//        animation: .default
//    ) private var splits: FetchedResults<ProgressiveOverloadTracker.WorkoutSplit>
//    
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                
//                // Intro Section
//                VStack(alignment: .leading, spacing: 10) {
//                    HStack {
//                        Image(systemName: "person.circle")
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 60, height: 60)
//                            .clipShape(Circle())
//                            .overlay(Circle().stroke(Color("accentColor"), lineWidth: 2))
//                        
//                        VStack(alignment: .leading) {
//                            Text("Fitness Journey and Beyond")
//                                .font(.largeTitle)
//                                .fontWeight(.bold)
//                                .foregroundColor(Color("primaryText"))
//                            
//                            Text("As a fitness enthusiast and iOS developer, I built this app to share my journey in a way that feels personal and interactive. By combining my love for tech with my passion for fitness, I’ve created a platform where I can document my progress, share ideas, and connect with others on similar paths. Through regular updates, honest reflections, and a focus on progressive overload tracking, my goal is to inspire everyone to start or keep going on their fitness journey. Whether you’re here to find inspiration or track your progress, enjoy the process and keep pushing forward!")
//                                .font(.body)
//                                .foregroundColor(Color("primaryText").opacity(0.8))
//                        }
//                    }
//                    
//                    HStack(spacing: 15) {
//                        Image(systemName: "link.circle.fill")
//                        Image(systemName: "envelope.circle.fill")
//                        Image(systemName: "bolt.circle.fill")
//                        // Customize your social icons as needed
//                    }
//                    .foregroundColor(Color("accentColor"))
//                    .padding(.top, 5)
//                }
//                .padding()
//                .background(Color("primaryBackground"))
//                .cornerRadius(12)
//                .padding([.top, .horizontal])
//                
//                // Articles Section
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Articles")
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                        .foregroundColor(Color("accentColor"))
//                    
//                    ForEach(0..<2) { _ in
//                        // Placeholder for articles
//                        Text("Sample Article Title")
//                            .font(.headline)
//                            .foregroundColor(Color("primaryText"))
//                            .padding(.vertical, 5)
//                    }
//                    
//                    NavigationLink(destination: ArticlesView()) {
//                        Text("View All Articles")
//                            .font(.subheadline)
//                            .foregroundColor(Color("accentColor"))
//                            .padding(.top, 5)
//                    }
//                }
//                .padding()
//                .background(Color("primaryBackground"))
//                .cornerRadius(12)
//                .padding(.horizontal)
//                
//                // Progress Tracker Section
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Progress Tracker")
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                        .foregroundColor(Color("accentColor"))
//                    
//                    ForEach(splits, id: \.self) { split in
//                        NavigationLink(destination: WorkoutSplitView(split: split)) {
//                            VStack(alignment: .leading) {
//                                Text(split.name ?? "Unnamed Split")
//                                    .font(.headline)
//                                    .foregroundColor(Color("primaryText"))
//                                
//                                Text("Created on \(split.creationDate ?? Date(), formatter: dateFormatter)")
//                                    .font(.caption)
//                                    .foregroundColor(Color.gray)
//                            }
//                            .padding()
//                            .background(Color("secondaryBackground"))
//                            .cornerRadius(8)
//                            .shadow(radius: 2)
//                        }
//                    }
//                    
//                    Button(action: addSplit) {
//                        Label("Add New Workout Split", systemImage: "plus")
//                            .foregroundColor(Color("accentColor"))
//                    }
//                    .padding(.top)
//                }
//                .padding()
//                .background(Color("primaryBackground"))
//                .cornerRadius(12)
//                .padding(.horizontal)
//            }
//        }
//        .background(Color("background").ignoresSafeArea())
//        .navigationTitle("Home")
//    }
//    
//    private func addSplit() {
//        withAnimation {
//            PersistenceController.shared.addWorkoutSplit(name: "New Split")
//        }
//    }
//}
//
//// Date formatter for displaying dates in a user-friendly format
//private let dateFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .medium
//    return formatter
//}()
