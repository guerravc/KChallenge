//
//  ListMoviesView.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 16/08/24.
//

import SwiftUI
import SwiftData

struct ListMoviesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @ObservedObject private var state: ListMoviesState = .init()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $state.selectedSection) {
                    ForEach(state.sections, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .onChange(of: state.selectedSection) {
                    switch state.selectedSection {
                        case .popular:
                            state.loadMostPopularMovies()
                            break
                        case .now:
                            state.loadNowPlayingMovies()
                            break
                    }
                }
                if state.selectedType == .list {
                    TableMoviesView(movies: $state.movies)
                        .navigationTitle(state.selectedSection.getText())
                        .toolbar {
                            HStack(alignment: .center) {
                                Button {
                                    state.selectedType = .grid
                                    state.loadMostPopularMovies()
                                } label: {
                                    Image(systemName: ListMoviesType.grid.getImageName())
                                }
                            }
                        }
                        .onAppear {
                            state.loadMostPopularMovies()
                        }
                } else {
                    GridMoviesView(movies: $state.movies)
                        .navigationTitle(state.selectedSection.getText())
                        .toolbar {
                            HStack(alignment: .center) {
                                Button {
                                    state.selectedType = .list
                                    state.loadMostPopularMovies()
                                } label: {
                                    Image(systemName: ListMoviesType.list.getImageName())
                                }
                            }
                        }
                        .onAppear {
                            state.loadMostPopularMovies()
                        }
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview(traits: .fixedLayout(width: 345, height: 150)) {
    ListMoviesView()
        .modelContainer(for: Item.self, inMemory: true)
}
