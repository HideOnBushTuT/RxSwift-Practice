//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by CBReno on 2019/6/17.
//  Copyright © 2019 CBReno. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let one = 1
        let two = 2
        let three = 3
        
        let observable: Observable<Int> = Observable<Int>.just(one)
        
        let observable2 = Observable.of(one, two, three)
        
        let observable3 = Observable.of([one, two, three])
        
        let observable4 = Observable.from([one, two, three])
        
    }


}

