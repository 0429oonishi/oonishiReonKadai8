//
//  ModelLocator.swift
//  oonishiReonKadai8
//
//  Created by 大西玲音 on 2021/07/05.
//

import Foundation

final class ModelLocator {
    // ValueUseCase のインスタンスを2画面で共有するため、シングルトン
    static let shared = ModelLocator()
    private init() { }
    
    let valueUseCase = ValueUseCase()
    
}
