//
//  NewsListView.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import SwiftUI
import Dependencies

struct NewsListView: View {
    @Bindable var viewModel: NewsListViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.articles.indices, id: \.self) { index in
                    NewsCardView(article: viewModel.articles[index])
                        .padding(.horizontal)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.openDetails(for: viewModel.articles[index])
                        }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("News")
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: "Search news"
        )
    }
}

#Preview() {
    let viewModel = withDependencies({
        $0.newsClient = .mock
    }) {
        NewsListViewModel()
    }
    
    NewsListView(viewModel: viewModel)
}
