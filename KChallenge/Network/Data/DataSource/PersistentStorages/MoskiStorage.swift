//
//  MoskiStorage.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation
import UIKit

final class MoskiStorage: MoskiLocalDataSource {
    
    static let shared = MoskiStorage()
    private let imageCache = NSCache<NSString, AnyObject>()
    
    private init(){}
    
    // Data fetch service methods goes here
    func getMoviePoster(request imageName: String) async throws -> UIImage {
        if let cachedImage = imageCache.object(forKey: imageName as NSString) as? UIImage {
            return cachedImage
        } else {
            throw ServerError.network(issue: .internalServerError)
        }
    }
    
    func saveImageInCache(imageName: String, image: UIImage) {
        imageCache.setObject(image, forKey: imageName as NSString)
    }
}
