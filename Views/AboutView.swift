import SwiftUI
import AVKit

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                
                // Profile Image
                Image("profileImage")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(.top, 20)
                    .padding(.bottom, 10)

                // Title and Introduction
                Text("Fitness Journey and Beyond")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    
                Text("""
                As a fitness enthusiast and iOS developer, I built this app to share my journey in a way that feels personal and interactive...
                """)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                // Media Carousel
                MediaCarouselView()
                    .frame(height: 250) // Adjust height based on your design

                // Social Links
                VStack(alignment: .center, spacing: 12) {
                    SocialLinkView(icon: "camera", label: "Follow on Instagram", url: "https://www.instagram.com/svley/")
                    SocialLinkView(icon: "link.circle", label: "Follow on GitHub", url: "https://github.com/kianis4/")
                    SocialLinkView(icon: "person.circle", label: "Follow on LinkedIn", url: "https://www.linkedin.com/in/suleyman-kiani-9249a0240/")
                    Divider().padding(.vertical, 8)
                    SocialLinkView(icon: "envelope.fill", label: "suley.kiani@outlook.com", url: "mailto:suley.kiani@outlook.com")
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
        }
        .navigationTitle("About")
    }
}

// Media Carousel
struct MediaCarouselView: View { 
    // Sample media URLs (images and video URLs)
    let media: [Media] = [
        .image("profileImage"), // Replace with real image names in assets
        .image("Progress5"), // Replace with other images
        .video(URL(string: "https://www.overload-pro.com/_next/static/videos/progress.93835af8a8976af7981acf09b1cc536f.mp4")!) // Sample video URL
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(media, id: \.self) { item in
                    if case let .image(imageName) = item {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else if case let .video(videoURL) = item {
                        ZStack {
                            Image(systemName: "video") // Placeholder for video thumbnail
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 200)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Button(action: {
                                playVideo(url: videoURL)
                            }) {
                                Image(systemName: "play.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    // Function to present video player
    func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        let playerController = AVPlayerViewController()
        playerController.player = player
        // Present the AVPlayerViewController (only works if this code is within a UIViewController)
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
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

// Media Enum to represent Image and Video
enum Media: Hashable {
    case image(String)
    case video(URL)
}


////
////  AboutView.swift
////  ProgressiveOverloadTracker
////
////  Created by Suleyman Kiani on 2024-10-28.
////
//
//import SwiftUI
//
//struct AboutView: View {
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .center, spacing: 16) { // Center alignment
//                
//                // Profile Image
//                Image("profileImage") // Replace with actual image set name
//                    .resizable()
//                    .frame(width: 120, height: 120)
//                    .clipShape(Circle())
//                    .padding(.top, 20)
//                    .padding(.bottom, 10)
//
//                // Title and Introduction
//                Text("Fitness Journey and Beyond")
//                    .font(.largeTitle)
//                    .bold()
//                    .multilineTextAlignment(.center)
//                    
//                Text("""
//                As a fitness enthusiast and iOS developer, I built this app to share my journey in a way that feels personal and interactive. By combining my love for tech with my passion for fitness, I’ve created a platform where I can document my progress, share ideas, and connect with others on similar paths.
//
//                Through regular updates, honest reflections, and a focus on progressive overload tracking, my goal is to inspire everyone to start or keep going on their fitness journey. Whether you’re here to find inspiration or track your progress, enjoy the process and keep pushing forward!
//                """)
//                    .font(.body)
//                    .multilineTextAlignment(.center)
//                    .foregroundColor(.secondary)
//                    .padding(.horizontal)
//
//                // Social Links with Centered Icons and Text
//                VStack(alignment: .center, spacing: 12) {
//                    SocialLinkView(icon: "camera", label: "Follow on Instagram", url: "https://www.instagram.com/svley/")
//                    SocialLinkView(icon: "link.circle", label: "Follow on GitHub", url: "https://github.com/kianis4/")
//                    SocialLinkView(icon: "person.circle", label: "Follow on LinkedIn", url: "https://www.linkedin.com/in/suleyman-kiani-9249a0240/")
//                    Divider()
//                        .padding(.vertical, 8)
//                    SocialLinkView(icon: "envelope.fill", label: "suley.kiani@outlook.com", url: "mailto:suley.kiani@outlook.com")
//                }
//                .frame(maxWidth: .infinity, alignment: .center) // Center the social links
//            }
//            .frame(maxWidth: .infinity, alignment: .center) // Center the entire VStack
//            .padding()
//        }
//        
////        .background(Color("background").edgesIgnoringSafeArea(.all)) // Apply background color
//        .navigationTitle("About")
//    }
//}
//
//// Social Link Component
//struct SocialLinkView: View {
//    var icon: String
//    var label: String
//    var url: String
//    
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 24, height: 24)
//                .foregroundColor(.gray)
//            
//            Link(label, destination: URL(string: url)!)
//                .font(.body)
//                .foregroundColor(.blue)
//                .padding(.leading, 4)
//        }
//        .frame(maxWidth: .infinity, alignment: .center) // Center the link within HStack
//    }
//}
//
