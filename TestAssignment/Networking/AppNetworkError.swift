//
//  AppNetworkError.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import Foundation

//TODO: - Need to add client to specify error here
enum AppNetworkError: Error, Equatable {
    case generic
    case unauthorized
    case noInternetConnection
    case canceled
    case unacceptableStatusCode(Int)
}
