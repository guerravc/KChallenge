//
//  NowPlayingMovies+Request.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

struct NowPlayingMoviesRequest: Codable {
    let page: Int
    let language: Language
}
