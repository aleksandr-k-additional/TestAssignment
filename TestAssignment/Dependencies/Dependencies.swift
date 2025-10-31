//
//  Dependencies.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import Foundation
import Dependencies

// MARK: - AppDataStorageKey

private enum NewsClientKey: DependencyKey {
    static let liveValue = NewsClient.live
}

extension DependencyValues {
    var newsClient: NewsClient {
        get { self[NewsClientKey.self] }
        set { self[NewsClientKey.self] = newValue }
    }
}
