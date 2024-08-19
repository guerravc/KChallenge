//
//  ListMovieModel.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

struct ListMovieModel: Identifiable {
    let id: String = UUID().uuidString
    let idMovie: Int
    let title: String
}
