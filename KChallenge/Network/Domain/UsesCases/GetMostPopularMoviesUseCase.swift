//
//  GetMostPopularMoviesUseCase.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

// MARK: Use Case
struct GetMostPopularMoviesUseCase: ParameteredResultUseCase {
    struct Input {
        let includeAdult: Bool
        let includeVideo: Bool
        let language: Language
        let page: Int
        let sortBy: String
    }
    
    @Inject private var gateway: MoskiGateway
    
    public func execute(_ input: Input, completion: @escaping GetMostPopularMoviesResult) {
        let request: MostPopularMoviesRequest = .init(includeAdult: input.includeAdult,
                                                      includeVideo: input.includeVideo,
                                                      language: input.language,
                                                      page: input.page,
                                                      sortBy: input.sortBy)
        gateway.getMostPopularMovies(request: request, completion: completion)
    }
}
