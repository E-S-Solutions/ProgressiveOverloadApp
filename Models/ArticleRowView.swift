//
//  ArticleRowView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//

import SwiftUI

struct ArticleRowView: View {
    var article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(article.title)
                .font(.headline)
                .lineLimit(2)

            Text(article.date)
                .font(.subheadline)
                .foregroundColor(.gray)

            Text(article.description)
                .font(.body)
                .lineLimit(3)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}



