//
//  SecondViewController.swift
//  oonishiReonKadai8
//
//  Created by 大西玲音 on 2021/06/27.
//

import UIKit
import RxSwift
import RxCocoa

final class SecondViewController: UIViewController {
    
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var numberSlider: UISlider!
    
    private let disposeBag = DisposeBag()
    private let secondViewModel: SecondViewModelType = SecondViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        secondViewModel.inputs.sliderValue.accept(0.0)
        
    }
    
    private func setupBindings() {
        numberSlider.rx.value
            .subscribe(onNext: { [weak self] value in
                self?.secondViewModel.inputs.sliderValue.accept(value)
            })
            .disposed(by: disposeBag)
        
        secondViewModel.outputs.numberText
            .drive(numberLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}

protocol SecondViewModelInput {
    var sliderValue: PublishRelay<Float> { get }
}

protocol SecondViewModelOutput: AnyObject {
    var numberText: Driver<String> { get }
}

protocol SecondViewModelType {
    var inputs: SecondViewModelInput { get }
    var outputs: SecondViewModelOutput { get }
}

final class SecondViewModel: SecondViewModelInput, SecondViewModelOutput {
    
    var sliderValue = PublishRelay<Float>()
    
    var numberText: Driver<String>
    
    init() {
        numberText = sliderValue
            .map { String($0) }
            .asDriver(onErrorDriveWith: .empty())
    }
    
}

extension SecondViewModel: SecondViewModelType {
    
    var inputs: SecondViewModelInput {
        return self
    }
    
    var outputs: SecondViewModelOutput {
        return self
    }
    
}
