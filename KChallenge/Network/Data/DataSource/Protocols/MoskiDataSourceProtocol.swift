//
//  MoskiDataSourceProtocol.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

// MARK: - Remote (Repository -> RemoteDataSource)
protocol MoskiRemoteDataSource {
  // TODO: Data fetch functions from server
    func getMostPopularMovies(request: MostPopularMoviesRequest) async throws -> MostPopularMoviesResponse
    func getNowPlayingMovies(request: NowPlayingMoviesRequest) async throws -> NowPlayingMoviesResponse
}

// MARK: - Local (Repository -> LocalDataSource)
protocol MoskiLocalDataSource {
 // TODO: Data fetch functions from local database

}
