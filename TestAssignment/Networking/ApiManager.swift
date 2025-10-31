//
//  ApiManager.swift
//  TestAssignment
//
//  Created by Aleksandr Khoroshun on 31.10.2025.
//


import Foundation
import Alamofire

@MainActor
public final class ApiManager {
    private let urlProvider: URLProvider
    private let configuration: URLSessionConfiguration
    private let session: Session
    //private let storage: AppDataStorage
    
    static var eventMonitors: [EventMonitor] {
#if DEBUG
        return [AlamofireLogger()]
#else
        return []
#endif
    }
    
    static func session(configuration: URLSessionConfiguration) -> Session {
        return Session(configuration: configuration, eventMonitors: ApiManager.eventMonitors)
    }
    
    public static let shared = ApiManager()
    
    private init(
        configuration: URLSessionConfiguration = URLSessionConfiguration.af.default,
        urlProvider: URLProvider = .live,
        //storage: AppDataStorage = .live
    ) {
        self.configuration = configuration
        self.session = Self.session(configuration: configuration)
        self.urlProvider = urlProvider
        //self.storage = storage
    }
    
    public func dataRequest<T: Decodable>(route: Route, queryItems: [QueryItem] = []) async throws -> T
    where T: Sendable {
        let request = session.request(
            constructURL(with: route, queryItems: queryItems),
            method: .get,
            interceptor: self
        )
        
        let task = request.validate().serializingDecodable(T.self, decoder: JSONDecoder.appJson)
        let response = await task.response
        
        switch response.result {
        case .success(let data):
            return data
        case .failure(let afError):
            //TODO: - Need to create AFError handler
            throw afError
        }
    }
    
    public func sendDataRequestDataResponse<T: Decodable, P: Encodable>(
        method: HTTPMethod,
        route: Route,
        queryItems: [QueryItem] = [],
        params: P?,
        encoder: ParameterEncoder = JSONParameterEncoder(encoder: .appJson)) async throws -> T
    where T: Sendable, P: Sendable {
        let request = session.request(
            constructURL(with: route, queryItems: queryItems),
            method: method,
            parameters: params,
            encoder: encoder,
            interceptor: self
        )
        
        let task = request.validate().serializingDecodable(T.self, decoder: JSONDecoder.appJson)
        let response = await task.response
        
        switch response.result {
        case .success(let data):
            return data
        case .failure(let afError):
            throw afError
        }
    }
    
    public func sendDataRequestVoidResponse<P: Encodable>(
        method: HTTPMethod,
        route: Route,
        queryItems: [QueryItem] = [],
        params: P? = nil,
        encoder: ParameterEncoder? = JSONParameterEncoder(encoder: .appJson)) async throws -> Void
    where P: Sendable {
        
        let request = session.request(
            constructURL(with: route, queryItems: queryItems),
            method: method,
            parameters: params,
            encoder: encoder ?? URLEncodedFormParameterEncoder.default,
            interceptor: self
        )
        
        let task = request.validate().serializingData()
        let response = await task.response
        switch response.result {
        case .success:
            return
        case .failure(let afError):
            throw afError
        }
    }
    
    public func upload<T: Decodable>(endpoint: UploadEndpoint) async throws -> T where T: Sendable {
        let multipartData = MultipartFormData()
        let url = constructURL(with: endpoint.route)
        
        endpoint.binaryItems.forEach {
            multipartData.append(
                $0.uploadData,
                withName: $0.uploadName,
                fileName: $0.uploadFileName,
                mimeType: "image/jpeg"
            )
        }
        
        for (key, value) in endpoint.textContent {
            multipartData.append(Data(value.utf8), withName: key)
        }
        
        let request = session.upload(
            multipartFormData: multipartData,
            to: url,
            method: HTTPMethod(uploadMethod: endpoint.method),
            interceptor: self
        )
        
        let task = request.validate().serializingDecodable(T.self, decoder: JSONDecoder.appJson)
        let response = await task.response
        
        switch response.result {
        case .success(let data):
            return data
        case .failure(let afError):
            throw afError
        }
    }
    
    public func download(with url: URL) async throws -> URL {
        let destination: DownloadRequest.Destination = { tmpURL, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(url.lastPathComponent)
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let request = session
            .download(
                url,
                interceptor: self,
                to: destination
            )
        let task = request.validate().serializingDownloadedFileURL()
        let response = await task.response
        
        switch response.result {
        case .success(let url):
            return url
        case .failure:
            guard let statusCode = response.response?.statusCode else {
                throw AppNetworkError.generic
            }
            throw  AppNetworkError.unacceptableStatusCode(statusCode)
        }
    }
    
    private func constructURL(with route: Route, queryItems: [QueryItem] = []) -> URL {
        let url = urlProvider.url()
        let query = queryItems.reduce([], { $0 + [$1.urlQueryItem] })
        return query.isEmpty ? url.appendingPathComponent(route.path) :
        url.appendingPathComponent( route.path).appending(queryItems: query)
    }
}

extension ApiManager: RequestInterceptor {
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        guard let token = storage.accessToken() else {
//            completion(.success(urlRequest))
//            return
//        }
        //var urlRequest = urlRequest
        //urlRequest.setValue("Token " + token, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetry)
            return
        }
        
        switch response.statusCode {
            
        case 401:
            NotificationCenter.default.post(name: .unauthorizedError, object: nil)
            //storage.clear()
            completion(.doNotRetry)
            
        case 500...599:
            if request.retryCount < 3 {
                completion(.retryWithDelay(3))
            } else {
                completion(.doNotRetry)
            }
            
        default:
            completion(.doNotRetry)
        }
    }
    
}

extension Alamofire.HTTPMethod {
    init(uploadMethod: UploadEndpoint.HTTPMethod) {
        switch uploadMethod {
        case .post:
            self = HTTPMethod.post
        case .patch:
            self = HTTPMethod.patch
        }
    }
}

extension Notification.Name {
    public static let unauthorizedError = Notification.Name("unauthorizedError")
}
