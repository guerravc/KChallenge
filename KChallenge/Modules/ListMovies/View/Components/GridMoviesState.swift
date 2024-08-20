//
//  GridMoviesState.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 19/08/24.
//

import Foundation

class GridMoviesState: ObservableObject {
    @Published var movies: [[ListMovieModel]]
    
    init(movies array: [ListMovieModel]) {
        var grid: [[ListMovieModel]] = []
        var aux = 0
        if !array.isEmpty {
            repeat {
                var gridRow: [ListMovieModel] = []
                gridRow.append(array[aux])
                aux += 1
                if aux < array.count {
                    gridRow.append(array[aux])
                    aux += 1
                    if aux < array.count {
                        gridRow.append(array[aux])
                        aux += 1
                    }
                }
                grid.append(gridRow)
            } while aux < array.count
        }
        movies = grid
    }
}
