//
//  ValueUseCase.swift
//  oonishiReonKadai8
//
//  Created by akio0911 on 2021/06/29.
//

import Foundation
import RxSwift
import RxRelay

final class ValueUseCase: ValueUseCaseProtocol {
    var value: Observable<Float> {
        valueRelay.asObservable()
    }
    private let valueRelay = BehaviorRelay<Float>(value: 0)

    func update(value: Float) {
        valueRelay.accept(value)
    }
}
