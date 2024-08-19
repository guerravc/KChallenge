//
//  InjectWrapper.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

@propertyWrapper
struct Inject<T> {
    private var service: T
    
    init() {
        let dependency = DependencyContainer.shared
        self.service = dependency.resolve(T.self)!
    }
    
    var wrappedValue: T {
        get { service }
        mutating set { service = newValue }
    }
}
