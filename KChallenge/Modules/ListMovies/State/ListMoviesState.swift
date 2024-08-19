//
//  ListMoviesState.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

class ListMoviesState: ObservableObject {
    func loadMostPopularMovies() {
        let input: GetMostPopularMoviesUseCase.Input = .init(includeAdult: false, includeVideo: false, language: .en, page: 1, sortBy: "popularity.desc")
        GetMostPopularMoviesUseCase().execute(input) { result in
            switch result {
            case let .success(movies):
                PrintLog.debug("\(movies)")
                break
            case let .failure(error):
                PrintLog.debug("\(error)")
                break
            }
        }
    }
}
