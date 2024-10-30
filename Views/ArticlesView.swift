//
//  ArticlesView.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//
//
//  ArticlesView.swift
//  ProgressiveOverloadTracker
//
import SwiftUI

struct ArticlesView: View {
    @State private var articles: [Article] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    @State private var expandedYear: Int? = nil
    @State private var expandedMonth: String? = nil

    private let articleService = ArticleService()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Header with Title and Description
                    Text("My Journey: Reflections and Insights - A Timeline")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    
                    Text("A collection of my thoughts and experiences as I navigate my fitness, academic, and professional journey, from setbacks to successes.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.bottom)

                    if isLoading {
                        ProgressView("Loading articles...")
                    } else if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    } else {
                        // Grouped and Collapsible Articles by Year and Month
                        ForEach(groupedArticlesByYear(), id: \.key) { year, articlesByMonth in
                            Section(header: YearHeaderView(year: year, expandedYear: $expandedYear)) {
                                if expandedYear == year {
                                    ForEach(articlesByMonth.keys.sorted(), id: \.self) { month in
                                        MonthSectionView(month: month, articles: articlesByMonth[month]!, expandedMonth: $expandedMonth)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
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

    // Function to group articles by year and month, parsing date strings into Date objects
    private func groupedArticlesByYear() -> [(key: Int, value: [String: [Article]])] {
        let calendar = Calendar.current
        let groupedByYear = Dictionary(grouping: articles) { article -> Int in
            if let date = DateFormatter.apiDateFormatter.date(from: article.date) {
                return calendar.component(.year, from: date)
            } else {
                return 0 // Default if date parsing fails
            }
        }
        
        return groupedByYear.mapValues { articles in
            Dictionary(grouping: articles) { article -> String in
                if let date = DateFormatter.apiDateFormatter.date(from: article.date) {
                    return DateFormatter.monthFormatter.string(from: date)
                } else {
                    return "Unknown" // Default if date parsing fails
                }
            }
        }
        .sorted { $0.key > $1.key }
    }
}

// Year Header Component
struct YearHeaderView: View {
    let year: Int
    @Binding var expandedYear: Int?

    var body: some View {
        HStack {
            Text("\(year)")
                .font(.title2)
                .bold()

            Spacer()

            Button(action: {
                withAnimation {
                    expandedYear = (expandedYear == year) ? nil : year
                }
            }) {
                Image(systemName: expandedYear == year ? "chevron.down" : "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}

// Month Section Component
struct MonthSectionView: View {
    let month: String
    let articles: [Article]
    @Binding var expandedMonth: String?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(month)
                    .font(.headline)

                Spacer()

                Button(action: {
                    withAnimation {
                        expandedMonth = (expandedMonth == month) ? nil : month
                    }
                }) {
                    Image(systemName: expandedMonth == month ? "chevron.down" : "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 4)

            if expandedMonth == month {
                ForEach(articles, id: \.id) { article in
                    ArticleRowView(article: article)
                        .padding(.leading, 8)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

// DateFormatter extensions for date parsing and month formatting
extension DateFormatter {
    static let apiDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Adjust to the actual date format in your API
        return formatter
    }()
    
    static let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()
    
    static let mediumFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}

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
//            } else if let errorMessage = errorMessage {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//            } else {
//                List(articles) { article in
//                    VStack(alignment: .leading) {
//                        Text(article.title)
//                            .font(.headline)
//                        Text(article.description)
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                        Text("Author: \(article.author) • Date: \(article.date)")
//                            .font(.footnote)
//                            .foregroundColor(.gray)
//                    }
//                }
//                .navigationTitle("Articles")
//            }
//        }
//        .onAppear {
//            articleService.fetchArticles { fetchedArticles in
//                DispatchQueue.main.async {
//                    if let fetchedArticles = fetchedArticles {
//                        self.articles = fetchedArticles
//                        self.isLoading = false
//                    } else {
//                        self.errorMessage = "Failed to load articles."
//                        self.isLoading = false
//                    }
//                }
//            }
//        }
//    }
//}


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

