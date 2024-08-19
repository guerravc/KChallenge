//
//  API+Moski.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

extension API.V3 {
    enum Moski: APIRouter{
        case getMostPopularMovies(request: MostPopularMoviesRequest)
        
        var scheme: String {
            switch API.version {
            case .V3:
                return AppInfo.schema
            }
        }
        
        var hostName: String {
            switch API.version {
            case .V3:
                return AppInfo.baseURL
            }
        }
        
        var path: String {
            switch self {
            case .getMostPopularMovies:
                return "/\(API.version.rawValue)/discover/movie"
            }
        }
        
        var method: HttpMethod {
            switch self {
            case .getMostPopularMovies:
                return .get
            }
        }
        
        var parameters: [URLQueryItem] {
            switch self {
            case let .getMostPopularMovies(request):
                let parameters = [URLQueryItem(name: "include_adult", value: "\(request.includeAdult)"),
                                  URLQueryItem(name: "include_video", value: "\(request.includeVideo)"),
                                  URLQueryItem(name: "language", value: "\(request.language.rawValue)"),
                                  URLQueryItem(name: "page", value: "\(request.page)"),
                                  URLQueryItem(name: "sort_by", value: "\(request.sortBy)")]
                return parameters
            }
        }
        
        var body: String? {
            switch self {
            case .getMostPopularMovies:
                return nil
            }
        }
        
        var authorizationToken: String? {
            switch self {
                
            case .getMostPopularMovies:
                return AppInfo.authenticationToken
            }
        }
        
        var authenticationType: String? {
            switch self {
            case .getMostPopularMovies:
                return NSURLAuthenticationMethodServerTrust
            }
        }
    }
}
