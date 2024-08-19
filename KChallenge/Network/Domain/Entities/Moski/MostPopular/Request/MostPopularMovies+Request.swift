//
//  MostPopularMovies+Request.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

struct MostPopularMoviesRequest {
    let includeAdult: Bool
    let includeVideo: Bool
    let language: Language
    let page: Int
    let sortBy: String
}
