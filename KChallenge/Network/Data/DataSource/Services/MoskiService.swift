//
//  MoskiService.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation
import UIKit

final class MoskiService: MoskiRemoteDataSource {
    
    static let shared = MoskiService()
    @Inject private var dispatcher: APIRequestDispatcher
    
    private init(){}
    
    // Data fetch service methods goes here
    
    func getMostPopularMovies(request: MostPopularMoviesRequest) async throws -> MostPopularMoviesResponse {
        let response: MostPopularMoviesResponse = try await dispatcher.request(apiRouter: API.V3.Moski.getMostPopularMovies(request: request))
        return response
    }
    
    func getNowPlayingMovies(request: NowPlayingMoviesRequest) async throws -> NowPlayingMoviesResponse {
        let response: NowPlayingMoviesResponse = try await dispatcher.request(apiRouter: API.V3.Moski.getNowPlayingMovies(request: request))
        return response
    }
    
    func getMoviePoster(request imageName: String) async throws -> UIImage {
        let result = try await dispatcher.downloadImage(apiRouter: API.V3.Moski.getMoviePoster(imageName: imageName))
        guard
            let httpURLResponse = result.response as? HTTPURLResponse,
            httpURLResponse.statusCode == 200,
            let mimeType = httpURLResponse.mimeType,
            mimeType.hasPrefix("image"),
            let image = UIImage(data: result.data)
        else { throw ServerError.objectSerialization(reason: "Cannot create Image from data") }
        
        return image
    }
}
