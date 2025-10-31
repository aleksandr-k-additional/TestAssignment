//
//  URLProvider.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import Foundation

public struct URLProvider: Sendable {
    public let url: @Sendable () -> URL
}

extension URLProvider {
    nonisolated public static var dev: Self {
        Self(
            url: { URL(string: "https://newsapi.org")! }
        )
    }
    
    nonisolated public static var live: Self {
        Self(
            url: { URL(string: "https://newsapi.org")! }
        )
    }
}

extension URL {
    func queryValue(for key: String) -> String? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return nil
        }
        return queryItems.first(where: { $0.name == key })?.value
    }
}
