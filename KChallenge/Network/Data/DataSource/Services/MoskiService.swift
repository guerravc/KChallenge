//
//  MoskiService.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

final class MoskiService: MoskiRemoteDataSource {
    
    static let shared = MoskiService()
    @Inject private var dispatcher: APIRequestDispatcher
    
    private init(){}
    
    // Data fetch service methods goes here
    
    func getMostPopularMovies(request: MostPopularMoviesRequest) async throws -> MostPopularMoviesResponse {
        let response: MostPopularMoviesResponse = try await dispatcher.request(apiRouter: API.V3.Moski.getMostPopularMovies(request: request))
        return response
    }
    
    func getNowPlayingMovies(request: NowPlayingMoviesRequest) async throws -> NowPlayingMoviesResponse {
        let response: NowPlayingMoviesResponse = try await dispatcher.request(apiRouter: API.V3.Moski.getNowPlayingMovies(request: request))
        return response
    }
}
