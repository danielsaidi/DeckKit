//
//  UserDefaultsPersisted.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-20.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefaultsPersisted<T: Codable> {
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    private let key: String
    private let defaultValue: T

    private var defaults: UserDefaults { .standard }

    var wrappedValue: T {
        get {
            guard let data = defaults.object(forKey: key) as? Data else { return defaultValue }
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            defaults.set(data, forKey: key)
        }
    }
}
