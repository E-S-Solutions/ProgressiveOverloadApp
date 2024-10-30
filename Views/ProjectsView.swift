//
//  ProjectsView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//

import SwiftUI

struct ProjectsView: View {
    let projects: [Project] = [
        Project(
            name: "SkompXcel",
            description: "Sole Proprietor - Expert tutoring and academic assistance...",
            link: URL(string: "https://skompxcel.com/")!,
            logo: "book"
        ),
        Project(
            name: "E&S Solns.",
            description: "Co-Founder and Lead Developer - Automation and software solutions for small businesses...",
            link: URL(string: "https://www.es-soln.com/")!,
            logo: "gear"
        )
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Things I’ve made trying to put my dent in the universe.")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                
                Text("I’ve worked on tons of little projects over the years but these are the ones that I’m most proud of. Many of them are open-source, so if you see something that piques your interest, check out the code and contribute if you have ideas for how it can be improved.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(projects, id: \.name) { project in
                            ProjectCard(project: project)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Projects")
        }
    }
}

struct ProjectCard: View {
    let project: Project
    
    var body: some View {
        VStack(spacing: 10) {
            // Placeholder Logo
            Image(systemName: project.logo)
                .resizable()
                .frame(width: 50, height: 50)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 4)
                .padding(8)
                .background(Circle().strokeBorder(Color.gray, lineWidth: 1))
            
            Text(project.name)
                .font(.headline)
            
            Text(project.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Link(destination: project.link) {
                HStack(spacing: 4) {
                    Image(systemName: "link")
                        .frame(width: 16, height: 16)
                    Text(project.link.absoluteString)
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.secondarySystemBackground)))
        .shadow(radius: 3)
    }
}

struct Project {
    let name: String
    let description: String
    let link: URL
    let logo: String
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
