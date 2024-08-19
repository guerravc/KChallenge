//
//  MoskiGateway.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

typealias GetMostPopularMoviesResult = (Result<[Movie], Error>) -> Void

protocol MoskiGateway {
  // TODO: Data fetch functions without knowing the source (API or Local)
    func getMostPopularMovies(request: MostPopularMoviesRequest, completion: @escaping GetMostPopularMoviesResult)
}
