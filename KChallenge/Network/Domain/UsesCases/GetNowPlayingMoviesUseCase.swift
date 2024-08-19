//
//  GetNowPlayingMoviesUseCase.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

struct GetNowPlayingMoviesUseCase: ParameteredResultUseCase {
    struct Input {
        let language: Language
        let page: Int
    }
    
    @Inject private var gateway: MoskiGateway
    
    public func execute(_ input: Input, completion: @escaping GetNowPlayingMoviesResult) {
        let request: NowPlayingMoviesRequest = .init(page: input.page,
                                                     language: input.language)
        gateway.getNowPlayingMovies(request: request, completion: completion)
    }
}
