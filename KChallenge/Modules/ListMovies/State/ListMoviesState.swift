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
    @Published var selectedType: ListMoviesType = .list
    var sections: [ListMoviesSection] = [.popular, .now]
    
    func loadMostPopularMovies() {
        let input: GetMostPopularMoviesUseCase.Input = .init(includeAdult: false,
                                                             includeVideo: false,
                                                             language: .en,
                                                             page: 1,
                                                             sortBy: "popularity.desc")
        GetMostPopularMoviesUseCase().execute(input) { [unowned self] result in
            switch result {
                case let .success(data):
                    DispatchQueue.main.async { [unowned self] in
                        movies = dataToMovies(data)
                    }
                    break
                case let .failure(error):
                    PrintLog.debug("\(error)")
                    break
            }
        }
    }
    
    func loadNowPlayingMovies() {
        let input: GetNowPlayingMoviesUseCase.Input = .init(language: .en,
                                                            page: 1)
        GetNowPlayingMoviesUseCase().execute(input) { [unowned self] result in
            switch result {
                case let .success(data):
                    DispatchQueue.main.async { [unowned self] in
                        movies = dataToMovies(data)
                    }
                    break
                case let .failure(error):
                    PrintLog.debug("\(error)")
                    break
            }
        }
    }
    
    private func dataToMovies(_ data: [Movie]) -> [ListMovieModel] {
        var tempMovies: [ListMovieModel] = []
        for movie in data {
            let tempMovie: ListMovieModel = .init(idMovie: movie.id,
                                                  title: movie.title, image: movie.posterPath)
            tempMovies.append(tempMovie)
        }
        return tempMovies
    }
}


enum ListMoviesType: String, Equatable {
    case grid
    case list
    
    static func == (lhs: ListMoviesType, rhs: ListMoviesType) -> Bool {
        switch (lhs, rhs) {
            case (.grid, .grid):
                return true
            case (.list, .list):
                return true
            default:
                return false
        }
    }
    
    func getImageName() -> String {
        switch self {
            case .grid:
                return "rectangle.grid.3x2"
            case .list:
                return "list.bullet"
        }
    }
}

enum ListMoviesSection: String, Equatable {
    case popular = "Most popular"
    case now = "Now playing"
    
    static func == (lhs: ListMoviesSection, rhs: ListMoviesSection) -> Bool {
        switch (lhs, rhs) {
            case (.popular, .popular):
                return true
            case (.now, .now):
                return true
            default:
                return false
        }
    }
    
    func getText() -> String {
        switch self {
            case .popular:
                return "Most Popular"
            case .now:
                return "Now Playing"
        }
    }
}
