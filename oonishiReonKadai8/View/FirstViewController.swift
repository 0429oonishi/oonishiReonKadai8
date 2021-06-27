//
//  FirstViewController.swift
//  oonishiReonKadai8
//
//  Created by 大西玲音 on 2021/06/27.
//

import UIKit
import RxSwift
import RxCocoa

final class FirstViewController: UIViewController {
    
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var numberSlider: UISlider!
    
    private let firstViewModel: FirstViewModelType = FirstViewModel()
    private let disopseBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        firstViewModel.inputs.sliderValue.accept(0.0)
        
    }
    
    private func setupBindings() {
        numberSlider.rx.value
            .subscribe(onNext: { [weak self] value in
                self?.firstViewModel.inputs.sliderValue.accept(value)
            })
            .disposed(by: disopseBag)
        
        firstViewModel.outputs.numberText
            .drive(numberLabel.rx.text)
            .disposed(by: disopseBag)
        
    }
    
}

protocol FirstViewModelInput {
    var sliderValue: PublishRelay<Float> { get }
}

protocol FirstViewModelOutput: AnyObject {
    var numberText: Driver<String> { get }
}

protocol FirstViewModelType {
    var inputs: FirstViewModelInput { get }
    var outputs: FirstViewModelOutput { get }
}

final class FirstViewModel: FirstViewModelInput, FirstViewModelOutput {
    
    var sliderValue = PublishRelay<Float>()
    
    var numberText: Driver<String>
    
    init() {
        numberText = sliderValue
            .map { String($0) }
            .asDriver(onErrorDriveWith: .empty())
    }
    
    
}

extension FirstViewModel: FirstViewModelType {
    
    var inputs: FirstViewModelInput {
        return self
    }
    
    var outputs: FirstViewModelOutput {
        return self
    }
    
}
