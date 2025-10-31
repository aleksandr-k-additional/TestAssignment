//
//  NewsCardView.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import SwiftUI

struct NewsCardView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                AppImageView(url: url)
            }
            
            Text(article.title ?? "No title")
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            Text(article.description ?? "No description")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
// MARK: - Preview

#Preview {
    NewsCardView(article: .mock)
}
