//
//  UserDefaultsDataStore.swift
//  oonishiReonKadai8
//
//  Created by 大西玲音 on 2021/06/27.
//

import Foundation

protocol DataStoreProtocol {
    func save(_ value: Float)
    func get() -> Float?
}

final class UserDefaultsDataStore: DataStoreProtocol {
    
    func save(_ value: Float) {
        UserDefaults.standard.set(value, forKey: "key")
    }
    
    func get() -> Float? {
        if let element = UserDefaults.standard.object(forKey: "key") as? Float {
            return element
        }
        return nil
    }
    
}
