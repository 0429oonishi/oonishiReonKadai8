//
//  ViewModel.swift
//  oonishiReonKadai8
//
//  Created by 大西玲音 on 2021/06/27.
//

import Foundation
import RxSwift
import RxCocoa

protocol ValueUseCaseProtocol {
    var value: Observable<Float> { get }
    func update(value: Float)
}

protocol ViewModelInput {
    func viewWillAppear()
    func didChangeSliderValue(value: Float)
}

protocol ViewModelOutput: AnyObject {
    var event: Driver<ViewModel.Event> { get }
    var numberText: Driver<String> { get }
}

protocol ViewModelType {
    var inputs: ViewModelInput { get }
    var outputs: ViewModelOutput { get }
}

final class ViewModel: ViewModelInput, ViewModelOutput {
    enum Event {
        case changeSliderValue(Float)
    }

    var event: Driver<Event> {
        eventRelay
            .asDriver(onErrorDriveWith: .empty())
    }
    private let eventRelay = PublishRelay<Event>()

    var numberText: Driver<String> {
        valueUseCase.value
            .map { String($0) }
            .asDriver(onErrorDriveWith: .empty())
    }

    let valueUseCase: ValueUseCaseProtocol

    private let viewWillAppearTrigger = PublishRelay<Void>()

    private let disposeBag = DisposeBag()
    
    init(valueUseCase: ValueUseCaseProtocol) {
        self.valueUseCase = valueUseCase

        setupBindings()
    }

    private func setupBindings() {
        viewWillAppearTrigger
            .withLatestFrom(valueUseCase.value)
            .map(Event.changeSliderValue)
            .bind(to: eventRelay)
            .disposed(by: disposeBag)
    }

    func viewWillAppear() {
        viewWillAppearTrigger.accept(())
    }

    func didChangeSliderValue(value: Float) {
        valueUseCase.update(value: value)
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
