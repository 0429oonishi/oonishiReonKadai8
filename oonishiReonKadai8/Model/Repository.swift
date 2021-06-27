//
//  Repository.swift
//  oonishiReonKadai8
//
//  Created by 大西玲音 on 2021/06/27.
//

import Foundation

protocol RepositoryProtocol {
    func save(_ value: Float)
    func get() -> Float?
}

final class Repository: RepositoryProtocol {
    
    private let dataStore: DataStoreProtocol
    
    init(dataStore: DataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func save(_ value: Float) {
        dataStore.save(value)
    }
    
    func get() -> Float? {
        return dataStore.get()
    }
    
}
