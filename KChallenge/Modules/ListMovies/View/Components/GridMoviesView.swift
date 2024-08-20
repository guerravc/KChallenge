//
//  GridMoviesView.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 19/08/24.
//

import SwiftUI

struct GridMoviesView: View {
    @ObservedObject private var state: GridMoviesState
    
    init(movies array: Binding<[ListMovieModel]>) {
        self.state = GridMoviesState(movies: array.wrappedValue)
    }
    
    var body: some View {
        ScrollView {
            Spacer()
                .frame(height: 15)
            Grid(alignment: .center) {
                let _ = PrintLog.debug("movies = \(state.movies)")
                ForEach(state.movies, id: \.self) { rowMovies in
                    GridRow {
                        ForEach(rowMovies, id: \.self) { movie in
                            VStack(alignment: .center, spacing: 5) {
                                MoskiAsyncImage(url: movie.image) { phase in
                                    switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .frame(width: 93, height: 140)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                        case .empty:
                                            ProgressView()
                                                .padding()
                                                .frame(width: 93, height: 140)
                                                .background(Color.gray.opacity(0.7))
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                        case .failure(let error):
                                            Image(systemName: "xmark.icloud")
                                                .frame(width: 93, height: 140)
                                                .background(Color.gray.opacity(0.7))
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                            let _ = print(error)
                                        @unknown default:
                                            EmptyView()
                                    }
                                    VStack(alignment: .leading) {
                                        Text("\(movie.title)")
                                            .lineLimit(2)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 30, alignment: .center)
                                            .padding([.bottom], 10)
                                    }
                                    
                                }
                                .padding([.top, .leading, .trailing], 10)
                            }
                        }
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 100, height: 180)
                    .padding([.top, .bottom], 20)
                    .padding([.leading, .trailing], 10)
                }
            }
            .background(Color(uiColor: UIColor.systemGray6))
            .frame(maxWidth: .infinity)
        }
        .background(Color(uiColor: UIColor.systemGray6))
    }
}
