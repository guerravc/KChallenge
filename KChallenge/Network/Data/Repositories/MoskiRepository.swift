//
//  MoskiRepository.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

final class MoskiRepository: MoskiGateway {
    
    
    @Inject private var remoteDataSource: MoskiRemoteDataSource
    @Inject private var localDateSource: MoskiLocalDataSource
    
    private init() {}
    
    static func make() -> MoskiGateway {
        MoskiRepository()
    }
    
    // Data fetch service methods goes here
    
    func getMostPopularMovies(request: MostPopularMoviesRequest, completion: @escaping GetMostPopularMoviesResult) {
        Task.init {
            do {
                let result = try await remoteDataSource.getMostPopularMovies(request: request)
                completion(.success(result.results))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
