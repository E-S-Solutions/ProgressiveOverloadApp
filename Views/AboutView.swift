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
                
                // Placeholder Image
                HStack {
                    Spacer()
                    Image(systemName: "person.circle.fill") // Placeholder for profile image
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                    Spacer()
                }

                // Title and Introduction
                Text("Fitness Journey and Beyond")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Text("""
                As a fitness enthusiast and iOS developer, I built this app to share my journey in a way that feels personal and interactive. By combining my love for tech with my passion for fitness, I’ve created a platform where I can document my progress, share ideas, and connect with others on similar paths.

                Through regular updates, honest reflections, and a focus on progressive overload tracking, my goal is to inspire everyone to start or keep going on their fitness journey. Whether you’re here to find inspiration or track your progress, enjoy the process and keep pushing forward!
                """)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .foregroundColor(.secondary)

                // Social Links
                VStack(alignment: .leading, spacing: 12) {
                    SocialLinkView(icon: "logo.twitter", label: "Follow on Twitter", url: "https://twitter.com/")
                    SocialLinkView(icon: "logo.instagram", label: "Follow on Instagram", url: "https://www.instagram.com/svley/")
                    SocialLinkView(icon: "logo.github", label: "Follow on GitHub", url: "https://github.com/kianis4/")
                    SocialLinkView(icon: "logo.linkedin", label: "Follow on LinkedIn", url: "https://www.linkedin.com/in/suleyman-kiani-9249a0240/")
                    Divider()
                        .padding(.vertical, 8)
                    SocialLinkView(icon: "envelope.fill", label: "suley.kiani@outlook.com", url: "mailto:suley.kiani@outlook.com")
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .background(Color("background").edgesIgnoringSafeArea(.all)) // Apply background color
        .navigationTitle("About")
    }
}

// Social Link Component
struct SocialLinkView: View {
    var icon: String
    var label: String
    var url: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.gray)
            
            Link(label, destination: URL(string: url)!)
                .font(.body)
                .foregroundColor(.blue)
                .padding(.leading, 4)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

