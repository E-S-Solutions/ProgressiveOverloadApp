//
//  WorkoutSplitView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//

import SwiftUI
import CoreData

struct WorkoutSplitView: View {
    var split: ProgressiveOverloadTracker.WorkoutSplit

    var body: some View {
        VStack {
            Text(split.name ?? "Unnamed Split")
                .font(.largeTitle)
                .padding()

            Text("Creation Date: \(split.creationDate ?? Date(), formatter: dateFormatter)")
                .font(.subheadline)
                .padding()

            Spacer()
        }
        .navigationTitle("Workout Split Details")
    }
}

// Date formatter to display dates in a user-friendly format
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()



