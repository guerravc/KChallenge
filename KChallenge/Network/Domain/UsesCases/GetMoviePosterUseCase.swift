//
//  GetMoviePosterUseCase.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 19/08/24.
//

import Foundation
import UIKit

struct GetMoviePosterUseCase: ParameteredAsyncResultUseCase {
    struct Input {
        let posterPath: String
    }
    
    @Inject private var gateway: MoskiGateway
    
    func execute(_ input: Input) async throws -> UIImage {
        try await gateway.getMoviePoster(request: input.posterPath)
    }
}
