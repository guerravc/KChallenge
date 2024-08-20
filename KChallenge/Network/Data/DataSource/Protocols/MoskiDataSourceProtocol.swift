//
//  MoskiDataSourceProtocol.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation
import UIKit

// MARK: - Remote (Repository -> RemoteDataSource)
protocol MoskiRemoteDataSource {
  // TODO: Data fetch functions from server
    func getMostPopularMovies(request: MostPopularMoviesRequest) async throws -> MostPopularMoviesResponse
    func getNowPlayingMovies(request: NowPlayingMoviesRequest) async throws -> NowPlayingMoviesResponse
    func getMoviePoster(request imageName: String) async throws -> UIImage
}

// MARK: - Local (Repository -> LocalDataSource)
protocol MoskiLocalDataSource {
 // TODO: Data fetch functions from local database
    func getMoviePoster(request imageName: String) async throws -> UIImage
    func saveImageInCache(imageName: String, image: UIImage)
}
