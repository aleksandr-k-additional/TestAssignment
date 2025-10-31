//
//  Article.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import Foundation

struct Article: nonisolated Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    var formattedDate: String {
        publishedAt?.toFormattedDate() ?? ""
    }
}


extension Article {
    static var mock: Article {
        .init(
            source: .mock,
            author: UUID().uuidString,
            title: "title" + UUID().uuidString,
            description: "description" + UUID().uuidString,
            url: "https://google.com.ua/",
            urlToImage: UUID().uuidString,
            publishedAt: UUID().uuidString,
            content: UUID().uuidString
        )
    }
}
