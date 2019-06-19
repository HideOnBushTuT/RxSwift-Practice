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
        
        
//        let one = 1
//        let two = 2
//        let three = 3
//
//        let observable: Observable<Int> = Observable<Int>.just(one)
//
//        let observable2 = Observable.of(one, two, three)
//
//        let observable3 = Observable.of([one, two, three])
//
//        let observable4 = Observable.from([one, two, three])
//
//
//        //
//        let observer = NotificationCenter.default.addObserver(
//            forName: UIResponder.keyboardDidChangeFrameNotification,
//            object: nil,
//            queue: nil) { (notification) in
//                print("UIResponder.keyboardDidChangeFrameNotification")
//        }
//
//
//        // --- Example of: manual ---
//        observable2.subscribe { event in
//            if let element = event.element {
//                print(element)
//            }
//        }
//
//        // --- Example of: auto ---
//        observable2.subscribe(onNext: { (element) in
//            print("element: \(element)")
//        }, onError: nil, onCompleted: nil, onDisposed: nil)
//
//
//        // --- Example of: empty ---
//        let emptyObservable = Observable<Void>.empty()
//
//        emptyObservable.subscribe { event in
//            print(event)
//        }
//
//        emptyObservable.subscribe(onNext: { (element) in
//            print("empty \(element)")
//        }, onError: nil, onCompleted: {
//            print("completed")
//        }, onDisposed: nil)
        
        // --- Example of: never ---
//        let neverObservable = Observable<Any>.never()
//
//        neverObservable.subscribe(
//            onNext: { element in
//                print(element)
//            },
//            onCompleted: {
//                print("Completed")
//            }
//        )
        
        // --- Example of: array ---
//        let rangeObservable = Observable<Int>.range(start: 1, count: 10)
//
//        rangeObservable
//            .subscribe(onNext: { (i) in
//                let n = Double(i)
//                let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
//                print("range: \(fibonacci)")
//            })
        
        // --- Example of: array ---
        
        
        
    }


}
