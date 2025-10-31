//
//  Source.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import Foundation

struct Source: nonisolated Codable {
    let id: String?
    let name: String?
}

extension Source {
    static var mock: Source {
        .init(id: nil, name: UUID().uuidString)
    }
}
