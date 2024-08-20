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
        case getNowPlayingMovies(request: NowPlayingMoviesRequest)
        case getMoviePoster(imageName: String)
        
        var scheme: String {
            switch API.version {
                case .V3:
                    return AppInfo.schema
            }
        }
        
        var hostName: String {
            switch API.version {
                case .V3:
                    switch self {
                        case .getMoviePoster:
                            return AppInfo.bucketURL
                        default:
                            return AppInfo.baseURL
                    }
            }
        }
        
        var path: String {
            switch self {
                case .getMostPopularMovies:
                    return "/\(API.version.rawValue)/discover/movie"
                case .getNowPlayingMovies:
                    return "/\(API.version.rawValue)/movie/now_playing"
                case let .getMoviePoster(imageName):
                    return "/t/p/original\(imageName)"
            }
        }
        
        var method: HttpMethod {
            switch self {
                case .getMostPopularMovies,
                        .getNowPlayingMovies,
                        .getMoviePoster:
                    return .get
            }
        }
        
        var parameters: [URLQueryItem] {
            switch self {
                case let .getMostPopularMovies(request):
                    let parameters = [URLQueryItem(name: "include_adult",
                                                   value: "\(request.includeAdult)"),
                                      URLQueryItem(name: "include_video",
                                                   value: "\(request.includeVideo)"),
                                      URLQueryItem(name: "language",
                                                   value: "\(request.language.rawValue)"),
                                      URLQueryItem(name: "page",
                                                   value: "\(request.page)"),
                                      URLQueryItem(name: "sort_by",
                                                   value: "\(request.sortBy)")]
                    return parameters
                case let .getNowPlayingMovies(request):
                    let parameters = [URLQueryItem(name: "language",
                                                   value: "\(request.language.rawValue)"),
                                      URLQueryItem(name: "page",
                                                   value: "\(request.page)")]
                    return parameters
                case .getMoviePoster:
                    return []
            }
        }
        
        var body: String? {
            switch self {
                case .getMostPopularMovies,
                        .getNowPlayingMovies,
                        .getMoviePoster:
                    return nil
            }
        }
        
        var authorizationToken: String? {
            switch self {
                    
                case .getMostPopularMovies,
                        .getNowPlayingMovies:
                    return AppInfo.authenticationToken
                case .getMoviePoster:
                    return nil
            }
        }
        
        var authenticationType: String? {
            switch self {
                case .getMostPopularMovies,
                        .getNowPlayingMovies:
                    return NSURLAuthenticationMethodServerTrust
                case .getMoviePoster:
                    return nil
            }
        }
    }
}
