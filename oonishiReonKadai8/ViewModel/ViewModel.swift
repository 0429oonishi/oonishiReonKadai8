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
}

protocol ViewModelOutput: AnyObject {
    var numberText: Driver<String> { get }
}

protocol ViewModelType {
    var inputs: ViewModelInput { get }
    var outputs: ViewModelOutput { get }
}

final class ViewModel: ViewModelInput, ViewModelOutput {
    var sliderValue = PublishRelay<Float?>()
    
    var numberText: Driver<String>
    
    init() {
        numberText = sliderValue
            .map { String($0 ?? 0.0) }
            .asDriver(onErrorDriveWith: .empty())
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
