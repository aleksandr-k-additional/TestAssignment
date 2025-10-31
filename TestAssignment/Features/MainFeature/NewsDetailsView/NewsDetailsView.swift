//
//  NewsDetailsView.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import SwiftUI

struct NewsDetailsView: View {
    let viewModel: NewsDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                if let imageUrl = viewModel.article.urlToImage, let url = URL(string: imageUrl) {
                    AppImageView(url: url)
                        .padding(.horizontal, 20)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.article.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    
                    Divider()

                    HStack {
                        Text(viewModel.article.author ?? "Unknown author")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(viewModel.article.formattedDate)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Divider()

                    if let description = viewModel.article.description, !description.isEmpty {
                        Text(description)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    
                    if let content = viewModel.article.content, !content.isEmpty {
                        Text(content)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.article.title)
    }
}

#Preview() {
    NewsDetailsView(viewModel: .init(article: .mock))
}
