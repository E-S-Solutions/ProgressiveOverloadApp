//
//  AboutView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Fitness Journey and Beyond")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("As a fitness enthusiast and iOS developer, I built this app to share my journey in a way that feels personal and interactive. By combining my love for tech with my passion for fitness, I’ve created a platform where I can document my progress, share ideas, and connect with others on similar paths.")
                    .font(.body)
                
                Text("My goal is to inspire everyone to start or keep going on their fitness journey, whether you're here for inspiration or to track your own progress. Enjoy the process and keep pushing forward!")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("About")
    }
}


