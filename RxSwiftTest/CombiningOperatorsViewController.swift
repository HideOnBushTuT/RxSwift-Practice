//
//  CombiningOperatorsViewController.swift
//  RxSwiftTest
//
//  Created by CBReno on 2019/7/2.
//  Copyright © 2019 CBReno. All rights reserved.
//

import UIKit
import RxSwift

class CombiningOperatorsViewController: UIViewController {
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        startWith()
//        observableConcat()
//        concat()
//        concatMap()
//        merge()
//        combineLatest()
//        combineUserChoiceAndValue()
        zip()
    }
    
    func startWith() -> Void {
        let numbers = Observable.of(2, 3, 4)
        
        let observable = numbers.startWith(1)
        _ = observable.subscribe(onNext: { (value) in
            print(value)
        })
    }
    
    func observableConcat() -> Void {
        let first = Observable.of(1, 2, 3)
        let second = Observable.of(4, 5, 6)
        
        let observable = Observable.concat([first, second])
        
        observable.subscribe(onNext: { (value) in
            print(value)
        })
        .disposed(by: bag)
    
    }
    
    func concat() -> Void {
        let germanCities = Observable.of("Berlin", "Munich", "Frankfurt")
        let spanishCities = Observable.of("Madrid", "Barcelona", "Valencia")
        
        let observable = germanCities.concat(spanishCities)
        _ = observable.subscribe(onNext: { (value) in
            print(value)
        })
    }
    
    func concatMap() -> Void {
        let sequences = [
            "German cities": Observable.of("Berlin", "Münich", "Frankfurt"),
            "Spanish cities": Observable.of("Madrid", "Barcelona", "Valencia")
        ]
        
        let observable = Observable.of("German cities", "Spanish cities")
            .concatMap { contry in sequences[contry] ?? .empty() }
        
        _ = observable.subscribe(onNext: { (string) in
            print(string)
        })
        
    }
    
    
    func merge() -> Void {
        let left = PublishSubject<String>()
        let right = PublishSubject<String>()
        
        let source = Observable.of(left.asObservable(), right.asObservable())
        
        let observable = source.merge()
        _ = observable.subscribe(onNext: { (value) in
            print(value)
        })
        
        var leftValues = ["Berlin", "Munich", "Frankfurt"]
        var rightValues = ["Madrid", "Barcelona", "Valencia"]
        
        repeat {
            switch Bool.random() {
            case true where !leftValues.isEmpty:
                left.onNext("Left: " + leftValues.removeFirst())
            case false where !rightValues.isEmpty:
                right.onNext("Right: " + rightValues.removeFirst())
            default:
                break
            }
        } while !leftValues.isEmpty || !rightValues.isEmpty
        
        left.onCompleted()
        right.onCompleted()
    }
    
    func combineLatest() -> Void {
        let left = PublishSubject<String>()
        let right = PublishSubject<String>()
        
        let observable = Observable.combineLatest(left, right) { lastLeft, lastRight in
            "\(lastLeft)\(lastRight)"
        }
        
        _ = observable.subscribe(onNext: { (value) in
            print(value)
        })
        
        print("> Sending a value to Left")
        left.onNext("Hello,")
        print("> Sending a value to Right")
        right.onNext("world")
        print("> Sending another value to Right")
        right.onNext("RxSwift")
        print("> Sending another value to Left")
        left.onNext("Have a good day,")
        
        left.onCompleted()
        right.onCompleted()
        
    }
    
    func combineUserChoiceAndValue() -> Void {
        let choice: Observable<DateFormatter.Style> = Observable.of(.short, .long)
        let dates = Observable.of(Date())
        
        let observable = Observable.combineLatest(choice, dates) {
            format, when -> String in
            let formatter = DateFormatter()
            formatter.dateStyle = format
            return formatter.string(from: when)
        }
        
        _ = observable.subscribe(onNext: { (value) in
            print(value)
        })
        
    }
    
    func zip() -> Void {
        enum Weather {
            case cloudy
            case sunny
        }
        
        let left: Observable<Weather> = Observable.of(.sunny, .cloudy, .cloudy, .sunny)
        let right = Observable.of("Lisbon", "Copenhagen", "London", "Madrid", "Vienna")
        
//        let observable = Observable.zip(left, right) { weather, city in
//            return "It's \(weather) in \(city)"
//        }
        let observable = Observable.zip(left, right) {
            "It's \($0) in \($1)"
        }
        
        _ = observable.subscribe(onNext: { (value) in
            print(value)
        })
        
        /***
         It's sunny in Lisbon
         It's cloudy in Copenhagen
         It's cloudy in London
         It's sunny in Madrid
        */
        /***
         “Did you notice how Vienna didn’t show up in the output? Why is that?
         The explanation lies in the way zip operators work. They pair each next value of each observable at the same logical position (1st with 1st, 2nd with 2nd, etc.). This implies that if no next value from one of the inner observables is available at the next logical position (i.e. because it completed, like in the example above), zip won‘t emit anything anymore. This is called indexed sequencing, which is a way to walk sequences in lockstep. But while zip may stop emitting values early, it won‘t itself complete until all its inner observables complete, making sure each can complete its work.”
        */
    }

}

