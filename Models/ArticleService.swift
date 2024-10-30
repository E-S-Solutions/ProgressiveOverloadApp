//
//  ArticleService.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//
import Foundation

class ArticleService {
    private let urlString = "https://www.overload-pro.com/_next/data/4XmRdBav5FvBpDy_wP-9Z/articles.json"

    func fetchArticles(completion: @escaping ([Article]?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Request error:", error)
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received.")
                completion(nil)
                return
            }

            do {
                let root = try JSONDecoder().decode(RootResponse.self, from: data)
                completion(root.pageProps.articles)
            } catch {
                print("Decoding error:", error)
                completion(nil)
            }
        }.resume()
    }
}

// Root structure to match JSON response
struct RootResponse: Decodable {
    let pageProps: PageProps
}

struct PageProps: Decodable {
    let articles: [Article]
}

//import Foundation
//
//class ArticleService {
//    private let urlString = "https://www.overload-pro.com/articles"
//
//
//    // Existing function to fetch raw data from the URL
//    func fetchArticlesRaw(completion: @escaping (Data?) -> Void) {
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            completion(nil)
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Request error:", error)
//                completion(nil)
//                return
//            }
//
//            if let data = data {
//                print("Raw data received:", String(data: data, encoding: .utf8) ?? "Invalid data format")
//                completion(data)
//            } else {
//                completion(nil)
//            }
//        }.resume()
//    }
//
//    // New function to decode sample JSON data for testing
//    func fetchSampleArticles(completion: @escaping ([Article]?) -> Void) {
//        print("fetchSampleArticles called") // Add this line
//
//        let sampleData = """
//        [
//            {
//                "uuid": "1",
//                "title": "Sample Article 1",
//                "summary": "This is a summary for article 1.",
//                "image_url": "https://example.com/image1.jpg",
//                "date": "2024-01-01"
//            },
//            {
//                "uuid": "2",
//                "title": "Sample Article 2",
//                "summary": "This is a summary for article 2.",
//                "image_url": "https://example.com/image2.jpg",
//                "date": "2024-02-01"
//            }
//        ]
//        """.data(using: .utf8)!
//
//        do {
//            let articles = try JSONDecoder().decode([Article].self, from: sampleData)
//            print("Decoded articles: \(articles)") // Add this line
//            completion(articles)
//        } catch {
//            print("Decoding error: \(error)")
//            completion(nil)
//        }
//    }
//
//    
//}
//

