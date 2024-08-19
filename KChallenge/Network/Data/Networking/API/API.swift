//
//  API.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

enum Version: Int {
    // MARK: V3 API Namespace
    case V3 = 3
}

protocol APIRouter {
    var scheme: String { get }
    var hostName: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var parameters: [URLQueryItem] { get }
    var body: String? { get }
    var authorizationToken: String? { get }
    var authenticationType: String? { get }
}

// MARK: API
struct API {
    
    static var version: Version = .V3
    static var configuration = SettingsHttpConfiguration()
    
    static func configure(_ request: inout URLRequest) {
        for (key, value) in API.configuration.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        request.timeoutInterval = API.configuration.requestTimeoutInterval
    }
}

extension API {
    enum V3 {}
}
