//
//  Article.swift
//  ProgressiveOverloadTracker
//
//  Created by Suleyman Kiani on 2024-10-28.
//

import Foundation

struct Article: Identifiable, Decodable {
    let id = UUID() // You can use a UUID as an ID if there's no unique ID in the JSON
    let slug: String
    let author: String
    let date: String
    let title: String
    let description: String
}


