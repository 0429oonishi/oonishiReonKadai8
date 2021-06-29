//
//  ModelLocator.swift
//  oonishiReonKadai8
//
//  Created by akio0911 on 2021/06/29.
//

import Foundation

final class ModelLocator {
    static let shared = ModelLocator()

    let valueUseCase = ValueUseCase()

    private init() {}
}
