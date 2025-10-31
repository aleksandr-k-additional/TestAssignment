//
//  NewsContainer.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import Foundation

struct NewsContainer: nonisolated Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}


extension NewsContainer {
    static var mock: NewsContainer {
        .init(
            status: "ok",
            totalResults: 3,
            articles: [
                .mock, .mock, .mock
            ]
        )
    }
}
