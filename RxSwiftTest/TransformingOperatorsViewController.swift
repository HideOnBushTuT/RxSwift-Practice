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


struct Student {
    let score: BehaviorSubject<Int>
}

class TransformingOperatorsViewController: UIViewController {
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

//        toArray()
//        map()
//        enumeratedMap()
//        flatMap()
//        flatMapLatest()
        materializeAndDematerialize()
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
    
    
    func flatMap() {
        let laura = Student(score: BehaviorSubject(value: 80))
        let charlotte = Student(score: BehaviorSubject(value: 90))
        
        let student = PublishSubject<Student>()
        
        student
            .flatMap {
                $0.score
            }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        student.onNext(laura)
        
        laura.score.onNext(99)
        
        student.onNext(charlotte)
        
        laura.score.onNext(95)
        
        charlotte.score.onNext(100)
        
        
        /***
         80
         99
         90
         95
         100
        **/
    }
    
    /**
     “What makes flatMapLatest different is that it will automatically switch to the latest observable and unsubscribe from the the previous one.”
     */
    func flatMapLatest() {
        /**
         “a simple example, imagine that you’re implementing a type-ahead search. As the user types each letter, s, w, i, f, t, you’ll want to execute a new search and ignore results from the previous one. flatMapLatest is how you do that.”
        */
        let laura = Student(score: BehaviorSubject(value: 80))
        let charlotte = Student(score: BehaviorSubject(value: 90))
        
        let student = PublishSubject<Student>()
        
        student
            .flatMapLatest {
                $0.score
        }
            .subscribe(onNext: {
                print($0)
        })
        .disposed(by: disposeBag)
        
        student.onNext(laura)
        laura.score.onNext(85)
        
        student.onNext(charlotte)
        
        laura.score.onNext(95)
        charlotte.score.onNext(100)
        
        
        /**
         80
         85
         90
         100
        */
    }
    
    
    func materializeAndDematerialize() {
        enum MyError: Error {
            case anError
        }
        
        let laura = Student(score: BehaviorSubject(value: 80))
        let charlotte = Student(score: BehaviorSubject(value: 100))
        
        let student = BehaviorSubject<Student>(value: laura)
        
        let studentScore = student
            .flatMapLatest {
                $0.score.materialize()
        }
        
//        studentScore
//            .subscribe(onNext: {
//                print($0.element)
//            })
//            .disposed(by: disposeBag)

        studentScore
            .filter {
                guard $0.error == nil else {
                    print($0.error!)
                    return false
                }
                return true
        }
        .dematerialize()
            .subscribe(onNext: {
                print($0)
            })
        .disposed(by: disposeBag)
        
        
        
        laura.score.onNext(85)
        
        laura.score.onError(MyError.anError)
        
        laura.score.onNext(90)
        
        student.onNext(charlotte)
        
    }
    
}
