//
//  MoskiGateway.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation
import UIKit

typealias GetMostPopularMoviesResult = (Result<[Movie], Error>) -> Void
typealias GetNowPlayingMoviesResult = (Result<[Movie], Error>) -> Void
typealias GetMoviePosterResult = (Result<UIImage, Error>) -> Void

protocol MoskiGateway {
  // TODO: Data fetch functions without knowing the source (API or Local)
    func getMostPopularMovies(request: MostPopularMoviesRequest, completion: @escaping GetMostPopularMoviesResult)
    func getNowPlayingMovies(request: NowPlayingMoviesRequest, completion: @escaping GetNowPlayingMoviesResult)
    func getMoviePoster(request imageName: String) async throws -> UIImage
}
