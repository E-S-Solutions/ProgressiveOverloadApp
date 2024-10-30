//
//  ArticleDetailView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: Article

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Placeholder for image or optional image handling
                // Since we don't have an `imageUrl`, we can omit this for now

                Text(article.title)
                    .font(.title)
                    .padding(.bottom, 4)
                
                Text(article.date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(article.description) // Using `description` as per JSON
                    .font(.body)
                    .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Article Details")
    }
}

