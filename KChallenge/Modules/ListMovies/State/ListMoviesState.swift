//
//  ListMoviesState.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

class ListMoviesState: ObservableObject {
    @Published var movies: [ListMovieModel] = []
    @Published var selectedSection: ListMoviesSection = .popular
    var sections: [ListMoviesSection] = [.popular, .now]
    
    func loadMostPopularMovies() {
        let input: GetMostPopularMoviesUseCase.Input = .init(includeAdult: false, includeVideo: false, language: .en, page: 1, sortBy: "popularity.desc")
        GetMostPopularMoviesUseCase().execute(input) { [unowned self] result in
            switch result {
            case let .success(data):
                var tempMovies: [ListMovieModel] = []
                for movie in data {
                    let tempMovie: ListMovieModel = .init(idMovie: movie.id, title: movie.title)
                    tempMovies.append(tempMovie)
                }
                movies = tempMovies
                break
            case let .failure(error):
                PrintLog.debug("\(error)")
                break
            }
        }
    }
}


enum ListMoviesSection: String {
    case popular = "Most popular"
    case now = "Now playing"
}
