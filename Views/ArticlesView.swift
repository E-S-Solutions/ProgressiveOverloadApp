//
//  ArticlesView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//
import SwiftUI

struct ArticlesView: View {
    @State private var articles: [Article] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    private let articleService = ArticleService()

    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView("Loading articles...")
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                List(articles) { article in
                    VStack(alignment: .leading) {
                        Text(article.title)
                            .font(.headline)
                        Text(article.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("Author: \(article.author) • Date: \(article.date)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                .navigationTitle("Articles")
            }
        }
        .onAppear {
            articleService.fetchArticles { fetchedArticles in
                DispatchQueue.main.async {
                    if let fetchedArticles = fetchedArticles {
                        self.articles = fetchedArticles
                        self.isLoading = false
                    } else {
                        self.errorMessage = "Failed to load articles."
                        self.isLoading = false
                    }
                }
            }
        }
    }
}


//import SwiftUI
//
//struct ArticlesView: View {
//    @State private var articles: [Article] = []
//    @State private var isLoading = true
//    @State private var errorMessage: String?
//
//    private let articleService = ArticleService()
//
//    var body: some View {
//        NavigationView {
//            if isLoading {
//                ProgressView("Loading articles...")
//                    .onAppear(perform: fetchArticles)
//            } else if let errorMessage = errorMessage {
//                Text("Error: \(errorMessage)")
//                    .foregroundColor(.red)
//                    .multilineTextAlignment(.center)
//                    .padding()
//            } else {
//                List(articles) { article in
//                    NavigationLink(destination: ArticleDetailView(article: article)) {
//                        ArticleRowView(article: article)
//                    }
//                }
//                .navigationTitle("Articles")
//            }
//        }
//    }
//
//    private func fetchArticles() {
//        articleService.fetchArticles { result in
//            DispatchQueue.main.async {
//                self.isLoading = false
//                switch result {
//                case .success(let articles):
//                    self.articles = articles
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
//}

