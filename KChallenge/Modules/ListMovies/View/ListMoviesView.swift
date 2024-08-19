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
        NavigationSplitView {
            List(state.movies) { movie in
                    Text(" \(movie.title)")
            }
            .onAppear {
                state.loadMostPopularMovies()
            }
        } detail: {
            Text("Select an item")
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
