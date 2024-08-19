//
//  Item.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 16/08/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
