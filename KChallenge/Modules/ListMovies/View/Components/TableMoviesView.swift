//
//  TableMoviesView.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 19/08/24.
//

import SwiftUI

struct TableMoviesView: View {
    @Binding var movies: [ListMovieModel]
    var body: some View {
        List(movies) { movie in
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .center, spacing: 0) {
                    MoskiAsyncImage(url: movie.image) { phase in
                        switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(width: 60, height: 90)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            case .empty:
                                ProgressView()
                                    .padding()
                                    .frame(width: 60, height: 90)
                                    .background(Color.gray.opacity(0.7))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            case .failure(let error):
                                Image(systemName: "xmark.icloud")
                                    .frame(width: 60, height: 90)
                                    .background(Color.gray.opacity(0.7))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                let _ = print(error)
                            @unknown default:
                                EmptyView()
                        }
                    }
                }
                
                VStack(alignment: .center,spacing: 0) {
                    Text(" \(movie.title)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
        }
    }
}
