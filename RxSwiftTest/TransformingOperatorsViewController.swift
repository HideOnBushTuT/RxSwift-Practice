//
//  TransformingOperatorsViewController.swift
//  RxSwiftTest
//
//  Created by CBReno on 2019/6/28.
//  Copyright © 2019 CBReno. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


struct Strudent {
    let score: BehaviorSubject<Int>
}

class TransformingOperatorsViewController: UIViewController {
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

//        toArray()
//        map()
        enumeratedMap()
    }
    
    func toArray() {
        Observable.of("A", "B", "C")
            .toArray()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }

    
    func map() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        Observable<Int>.of(123, 4, 56)
            .map {
                formatter.string(from: NSNumber(value: $0)) ?? ""
            }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    func enumeratedMap() {
        Observable.of(1, 2, 3, 4, 5, 6)
            .enumerated()
            .map { index, interger in
                index > 2 ? interger * 2 : interger
            }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
}
