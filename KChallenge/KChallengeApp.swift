//
//  KChallengeApp.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 16/08/24.
//

import SwiftUI
import SwiftData

@main
struct KChallengeApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ListMoviesView()
        }
        .modelContainer(sharedModelContainer)
    }
}
