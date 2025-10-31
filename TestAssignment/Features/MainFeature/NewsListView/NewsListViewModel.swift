//
//  NewsListViewModel.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import Foundation
import Dependencies
import XCTestDynamicOverlay

@Observable
class NewsListViewModel {
    var onDetails: (Article) -> Void = unimplemented()
    
    @ObservationIgnored
    @Dependency(\.newsClient) private var newsClient
    
    var container: NewsContainer?
    
    var articles: [Article] {
        container?.articles ?? []
    }
    
    init() {
        Task { [weak self] in
            self?.container = try? await self?.newsClient.getNews()
        }
    }
    
    func openDetails(for article: Article) {
        onDetails(article)
    }
}
