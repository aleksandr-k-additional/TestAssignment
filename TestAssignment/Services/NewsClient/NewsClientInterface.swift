//
//  NewsClient.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

struct NewsClient {
    public var getNews: @Sendable () async throws -> NewsContainer
}
