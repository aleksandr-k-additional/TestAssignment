//
//  URL.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//

import Foundation

public struct Endpoint {
    public let route: Route
    public var queryItems: [QueryItem] = []
    public init(route: Route, queryItems: [QueryItem] = []) {
        self.route = route
        self.queryItems = queryItems
    }
}

public struct UploadEndpoint {
    public struct Binary {
        public var uploadData: Data
        public var uploadName: String
        public var uploadFileName: String?
        
        public init(uploadData: Data, uploadName: String, uploadFileName: String? = nil) {
            self.uploadData = uploadData
            self.uploadName = uploadName
            self.uploadFileName = uploadFileName
        }
    }
    
    public enum HTTPMethod: String {
        case post = "POST"
        case patch = "PATCH"
    }
    
    public let route: Route
    public let method: HTTPMethod
    public let binaryItems: [Binary]
    public var textContent: [String: String] = [:]
    
    public init(route: Route, method: HTTPMethod, binaryItems: [UploadEndpoint.Binary], textContent: [String : String] = [:]) {
        self.route = route
        self.method = method
        self.binaryItems = binaryItems
        self.textContent = textContent
    }
}

public enum Route {
    case everything

    
    public var path: String {
        switch self {
        case .everything:
            "/v2/everything"
        }
    }
}

public enum QueryItem {
    case q(String)
    case from(String)
    case sortBy(String)
    case apiKey(String)
    public var urlQueryItem: URLQueryItem {
        switch self {
        case .q(let value):
            return URLQueryItem(name: "q", value: value)
        case .from(let value):
            return URLQueryItem(name: "from", value: value)
        case .sortBy(let value):
            return URLQueryItem(name: "sortBy", value: value)
        case .apiKey(let value):
            return URLQueryItem(name: "apiKey", value: value)
        }
    }
}
