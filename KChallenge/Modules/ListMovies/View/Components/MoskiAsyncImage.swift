//
//  MoskiAsyncImage.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 19/08/24.
//

import SwiftUI

struct MoskiAsyncImage<Content: View>: View {
    
    @State private var uiImage: UIImage?
    @State private var failed: Bool = false
    
    let url: String
    let content: (AsyncImagePhase) -> Content
    
    init(
        url: String,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ){
        self.url = url
        self.content = content
    }
    
    var body: some View {
        if let uiImage = uiImage {
            content(.success(Image(uiImage: uiImage)))
        }else {
            if !failed {
                content(.empty)
                    .task {
                        do {
                            failed = false
                            self.uiImage = try await GetMoviePosterUseCase().execute(.init(posterPath: url))
                        } catch {
                            failed = true
                        }
                    }
            } else {
                content(.failure(ServerError.unknown))
            }
        }
    }
}
