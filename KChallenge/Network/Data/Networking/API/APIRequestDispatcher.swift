//
//  APIRequestDispatcher.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

protocol Dispatcher {
    func createAPIRequest(_ apiRouter: some APIRouter) throws -> URLRequest
    func request<T: Codable>(apiRouter: APIRouter) async throws -> T
}

class APIRequestDispatcher: Dispatcher {
    
    static let shared = APIRequestDispatcher.init()
    
    private init() {
        
    }
    
    func createAPIRequest(_ apiRouter: some APIRouter) throws -> URLRequest {
        var components = URLComponents()
        components.host = apiRouter.hostName
        components.scheme = apiRouter.scheme
        components.path = apiRouter.path
        components.queryItems = apiRouter.parameters
        
        guard let url = components.url else { throw ServerError.badUrl }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = apiRouter.method.rawValue
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        API.configure(&request)
        
        if let authToken = apiRouter.authorizationToken, !authToken.isEmpty {
            if apiRouter.authenticationType == NSURLAuthenticationMethodHTTPBasic {
                request.addValue("Basic \(authToken)", forHTTPHeaderField: "Authorization")
            } else if apiRouter.authenticationType == NSURLAuthenticationMethodServerTrust {
                request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
            } else {
                request.addValue(authToken, forHTTPHeaderField: "Authorization")
            }
        }
        
        if let dataBody = apiRouter.body {
            request.httpBody = dataBody.data(using: String.Encoding.utf8)
        }
        
        return request
    }
    
    func request<T: Codable>(apiRouter: APIRouter) async throws -> T {
        
        guard let urlRequest = try? createAPIRequest(apiRouter) else {
            throw ServerError.badUrl
        }
        
        let session = URLSession(configuration: .default)
        return try await withCheckedThrowingContinuation { continuation in
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    return continuation.resume(with: .failure(error))
                }
                
                guard let data = data else {
                    return continuation.resume(with: .failure(ServerError.network(issue: .resourceNotFound)))
                }
                
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        return continuation.resume(with: .success(responseObject))
                    }
                } catch {
                    return continuation.resume(with: .failure(error))
                }
            }
            dataTask.resume()
        }
    }
    
    func downloadImage(apiRouter: APIRouter) async throws -> (data: Data, response: URLResponse) {
        guard let urlRequest = try? createAPIRequest(apiRouter) else {
            throw ServerError.badUrl
        }
        
        let session = URLSession(configuration: .default)
        
        return try await session.data(for: urlRequest)
    }
}
