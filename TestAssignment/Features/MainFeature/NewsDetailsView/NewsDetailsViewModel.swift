//
//  NewsDetailsViewModel.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//


import Foundation
import XCTestDynamicOverlay

@Observable
class NewsDetailsViewModel {
    var article: Article
    
    init(article: Article) {
        self.article = article
    }
}
