//
//  ValueUseCase.swift
//  oonishiReonKadai8
//
//  Created by 大西玲音 on 2021/07/05.
//

import RxSwift
import RxRelay

protocol ValueUseCaseProtocol {
    var value: Observable<Float> { get }
    func update(value: Float)
}

// 値を変更でき、現在値を監視できる
final class ValueUseCase: ValueUseCaseProtocol {
    
    private let valueRelay = BehaviorRelay<Float>(value: 0)
    var value: Observable<Float> {
        valueRelay.asObservable()
    }
    
    func update(value: Float) {
        valueRelay.accept(value)
    }
    
}
