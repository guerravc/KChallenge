//
//  DependencyContainer.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

class DependencyContainer {
    static let shared = DependencyContainer()
    
    private var dispatcher: APIRequestDispatcher {
        APIRequestDispatcher.shared
    }
    private var remoteDataSource: MoskiRemoteDataSource {
        MoskiService.shared
    }
    private var localDataSource: MoskiLocalDataSource {
        MoskiStorage.shared
    }
    private var gateway: MoskiGateway {
        MoskiRepository.make()
    }
    
    private init() {
    }
}

extension DependencyContainer {
    func resolve<T>(_ type: T.Type) -> T? {
        switch type {
        case is MoskiRemoteDataSource.Protocol:
            return remoteDataSource as? T
        case is MoskiLocalDataSource.Protocol:
            return localDataSource as? T
        case is APIRequestDispatcher.Type:
            return dispatcher as? T
        case is MoskiGateway.Protocol:
            return gateway as? T
        default:
            return nil
        }
    }
}
