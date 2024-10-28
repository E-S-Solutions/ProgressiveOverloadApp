//
//  MainTabView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            AboutView()
                .tabItem {
                    Label("About", systemImage: "person.fill")
                }
            
            ArticlesView()
                .tabItem {
                    Label("Articles", systemImage: "book.fill")
                }
            
            ProjectsView()
                .tabItem {
                    Label("Projects", systemImage: "folder.fill")
                }
            
            ProgressTrackerView()
                .tabItem {
                    Label("Progress", systemImage: "chart.bar.fill")
                }
        }
    }
}
