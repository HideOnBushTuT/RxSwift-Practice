//
//  FilteringOperatorsViewController.swift
//  RxSwiftTest
//
//  Created by CBReno on 2019/6/27.
//  Copyright © 2019 CBReno. All rights reserved.
//

import UIKit
import RxSwift

class FilteringOperatorsViewController: UIViewController {
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ignoreElements()
//        elementAt()
//        filter()
//        skip()
//        skipWhile()
//        skipUntil()
//        take()
//        takeWhile()
//        takeUntil()
//        distinctUntilChanged()
        customDistinctUntilChanged()
    }
    
    
    //MARK: Ignore Operator
    func ignoreElements() {
        let strikes = PublishSubject<String>()
        
        strikes
            .ignoreElements()
            .subscribe { _ in
                print("You're out !")
                
            }
            .disposed(by: bag)
        
        
        strikes.onNext("1)")
        strikes.onNext("2)")
        strikes.onNext("3)")
        
//        strikes.onCompleted()
        
    }
    
    func elementAt() {
        let strikes = PublishSubject<String>()
        strikes
            .elementAt(2)
            .subscribe(onNext: { (_) in
                print("You're out !")
            })
            .disposed(by: bag)
        
        strikes.onNext("1)")
        strikes.onNext("2)")
        strikes.onNext("3)")
        
        strikes.onCompleted()
    }
    
    
    func filter() {
        Observable.of(1, 2, 3, 4, 5, 6)
            .filter { $0 % 2 == 0 }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: bag)
    }
    
    //MARK: skip operator
    
    func skip() {
        Observable.of("A", "B", "C", "D", "E", "F")
            .skip(3)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: bag)
        
        
    }
    
    // “skipWhile, returning true will cause the element to be skipped, and returning false will let it through.”
    func skipWhile() {
        Observable.of(2, 2, 3, 4, 4)
            .skipWhile { $0 % 2 == 0 }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: bag)
        
    }


    func skipUntil() {
        let subject = PublishSubject<String>()
        let trigger = PublishSubject<String>()
        
        subject
            .skipUntil(trigger)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: bag)
        
        subject.onNext("A")
        subject.onNext("B")
        
        trigger.onNext("X")
        
        subject.onNext("C")
        
    }
    
    
    //MARL: take operator
    
    func take() {
        Observable.of(1, 2, 3, 4, 5, 6)
            .take(3)
            .subscribe { print($0) }
            .disposed(by: bag)
    }
    
    
    func takeWhile() {
        Observable.of(2, 2, 4, 4, 6, 6)
            .enumerated()
            .takeWhile { (index, integer) -> Bool in
                return integer % 2 == 0 && index < 3
            }
            .map { $0.element }
            .subscribe { print($0) }
            .disposed(by: bag)
        
        Observable.of(2, 2, 4, 4, 6, 6)
            .enumerated()
            .takeWhile { (index, integer) in
                integer % 2 == 0 && index < 3
            }
            .map { $0.element }
            .subscribe { print($0) }
            .disposed(by: bag)
    }
    
    
    func takeUntil() {
        let subject = PublishSubject<String>()
        let trigger = PublishSubject<String>()
        
        subject
            .takeUntil(trigger)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: bag)
        
        subject.onNext("1")
        subject.onNext("2")
        
        trigger.onNext("X")
        
        subject.onNext("3")
        
    }
    
    //MARK: Distinct operatoer
    
    func distinctUntilChanged() {
        
        /**
         “These are strings, which conform to Equatable. So, these elements are compared for equality based on their implementation conforming to Equatable. However, you can provide your own custom comparing logic by using distinctUntilChanged(_:), where the externally unnamed parameter is a comparer.”
        **/
        Observable.of("A", "A", "B", "B", "A")
            .distinctUntilChanged()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: bag)
    }
    
    func customDistinctUntilChanged() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        Observable<NSNumber>.of(10, 110, 20, 200, 210, 310)
            .distinctUntilChanged { (a, b) -> Bool in
                guard let aWords = formatter.string(from: a)?.components(separatedBy: ""),
                    let bWords = formatter.string(from: b)?.components(separatedBy: "")
                    else {
                        return false
                }
                
                var containsMatch = false
                for aWord in aWords where bWords.contains(aWord) {
                    containsMatch = true
                    break
                }
                
                return containsMatch
                
            }
            .subscribe(onNext: {
                print($0)
            })
        .disposed(by: bag)
    }
    
    
    //MARK: Challenge
    
    func phoneNumber(from inputs: [Int]) -> String {
        var phone = inputs.map(String.init).joined()
        
        phone.insert("-", at: phone.index(phone.startIndex, offsetBy: 3))
        
        phone.insert("-", at: phone.index(phone.startIndex, offsetBy: 7))
        
        return phone
    }
}
    
    


