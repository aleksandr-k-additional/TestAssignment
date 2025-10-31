//
//  NewsClientMock.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import Foundation

extension NewsClient {
    static var mock: Self {
        .init(
            getNews: {
                await .mock
            }
        )
    }
}
