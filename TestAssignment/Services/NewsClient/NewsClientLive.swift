//
//  NewsClientLive.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import Foundation

extension NewsClient {
    static var live: Self {
        .init(getNews: { 
            try await ApiManager.shared.dataRequest(route: .everything, queryItems: [
                .q("tesla"),
                .from("2025-10-06"),
                .sortBy("publishedAt"),
                .apiKey("961b5d69832044dbaef75c5ad5df2ba6")
            ])
        })
    }
}
