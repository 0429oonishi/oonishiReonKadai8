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
    
    private let secondViewModel: ViewModelType = ViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        secondViewModel.inputs.sliderValue.accept(
            secondViewModel.outputs.get()
        )

    }
    
    private func setupBindings() {
        numberSlider.rx.value
            .subscribe(onNext: { [weak self] value in
                self?.secondViewModel.inputs.save(value)
                self?.secondViewModel.inputs.sliderValue.accept(value)
            })
            .disposed(by: disposeBag)
        
        secondViewModel.outputs.numberText
            .drive(numberLabel.rx.text)
            .disposed(by: disposeBag)
        
        secondViewModel.outputs.changeSliderValue
            .drive(numberSlider.rx.value)
            .disposed(by: disposeBag)
    }
    
}
