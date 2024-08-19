//
//  MoskiConfiguration.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

enum MoskiConfiguration {
    enum InfoKey: String {
        case schema = "Schema"
        case baseURL = "BaseURL"
        case bucketURL = "BucketURL"
        case v3PAT = "MoskiV3PAT"
    }
    
    enum MCError: Error {
        case missingKey, invalidValue
    }
    
    static func value<T>(for key: InfoKey) throws -> T where T: LosslessStringConvertible {
        try value(for: key.rawValue)
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw MCError.missingKey
        }

        guard let value = object as? T else {
            throw MCError.invalidValue
        }
        return value
    }
}
