//
//  ViewModel.swift
//  oonishiReonKadai8
//
//  Created by 大西玲音 on 2021/06/27.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelInput {
    var sliderValue: PublishRelay<Float?> { get }
    func save(_ value: Float?)
}

protocol ViewModelOutput: AnyObject {
    var numberText: Driver<String> { get }
    var changeSliderValue: Driver<Float> { get }
    func get() -> Float
}

protocol ViewModelType {
    var inputs: ViewModelInput { get }
    var outputs: ViewModelOutput { get }
}

final class ViewModel: ViewModelInput, ViewModelOutput {
    var sliderValue = PublishRelay<Float?>()
    
    var numberText: Driver<String>
    var changeSliderValue: Driver<Float>
    let repository = Repository(
        dataStore: UserDefaultsDataStore()
    )
    
    init() {
        numberText = sliderValue
            .map { String($0 ?? 0.0) }
            .asDriver(onErrorDriveWith: .empty())
        
        changeSliderValue = sliderValue
            .map { $0 ?? 0.0 }
            .asDriver(onErrorDriveWith: .empty())
    }
    
    func save(_ value: Float?) {
        repository.save(value ?? 0.0)
    }
    
    func get() -> Float {
        return repository.get() ?? 0.0
    }
    
}

extension ViewModel: ViewModelType {
    
    var inputs: ViewModelInput {
        return self
    }
    
    var outputs: ViewModelOutput {
        return self
    }
    
}
