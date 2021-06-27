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
    
    private let firstViewModel: ViewModelType = ViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        firstViewModel.inputs.sliderValue.accept(
            firstViewModel.outputs.get()
        )
        
    }
    
    private func setupBindings() {
        numberSlider.rx.value
            .subscribe(onNext: { [weak self] value in
                self?.firstViewModel.inputs.save(value)
                self?.firstViewModel.inputs.sliderValue.accept(value)
            })
            .disposed(by: disposeBag)
        
        firstViewModel.outputs.numberText
            .drive(numberLabel.rx.text)
            .disposed(by: disposeBag)
        
        firstViewModel.outputs.changeSliderValue
            .drive(numberSlider.rx.value)
            .disposed(by: disposeBag)
    }
    
}
