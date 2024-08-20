//
//  ListMovieModel.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

struct ListMovieModel: Identifiable, Hashable, Equatable {
    let id: String = UUID().uuidString
    let idMovie: Int
    let title: String
    let image: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(idMovie)
        hasher.combine(title)
        hasher.combine(image)
    }
    
    static func == (lhs: ListMovieModel, rhs: ListMovieModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.idMovie == rhs.idMovie &&
        lhs.title == rhs.title &&
        lhs.image == rhs.image
    }
}
