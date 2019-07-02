//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by CBReno on 2019/6/17.
//  Copyright © 2019 CBReno. All rights reserved.
//

import UIKit
import RxSwift


//enum MyError: Error {
//    case anError
//}

enum FileReadError: Error {
    case fileNotFound, unreadable, encodingFailed
}


class ViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coVC = CombiningOperatorsViewController()
        addChild(coVC)
        view.addSubview(coVC.view)
        
        
//        let toVC = TransformingOperatorsViewController()
//        addChild(toVC)
//        view.addSubview(toVC.view)
        
//        let foVC = FilteringOperatorsViewController()
//        addChild(foVC)
//        view.addSubview(foVC.view)
//        let subjectsVC = SubjectsViewController()
//        subjectsVC.view.frame = view.bounds;
//        addChild(subjectsVC)
//        view.addSubview(subjectsVC.view)
        // MARK: Subscribing to observables
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
        
        
        // MARK: Disposing and terminating
        // --- Example of: dispose subscription ---
//        let disposeObservable = Observable.of("A", "B", "C")
//
//        let subscription = disposeObservable.subscribe { event in
//            print(event)
//        }
//
//        subscription.dispose()
        
        // --- Example of: dispose subscription ---
//        Observable.of("A", "B", "C")
//            .subscribe {
//                print($0)
//            }
//            .disposed(by: disposeBag)
        
        
        // --- Example of: create ---
//        Observable<String>.create { observer in
//            observer.onNext("1")
//
//            observer.onError(MyError.anError)
//
//            observer.onCompleted()
//
//            observer.onNext("?")
//
//            return Disposables.create()
//        }
//        .subscribe(
//            onNext: { print($0) },
//            onError: { print($0) },
//            onCompleted: { print("Completed") },
//            onDisposed: { print("Disposed") })
//        .disposed(by: disposeBag)
        
        //MARK: Creating observable factories
        
//        // 1
//        var flip = false
//
//        // 2
//        let factory: Observable<Int> = Observable.deferred {
//
//            // 3
//            flip.toggle()
//
//            // 4
//            if flip {
//                return Observable.of(1, 2, 3)
//            } else {
//                return Observable.of(4, 5, 6)
//            }
//        }
//
//        for _ in 0...3 {
//            factory.subscribe(onNext: {
//                print($0, terminator: "")
//            })
//            .disposed(by: disposeBag)
//        }
        
        
        // --- Example of: traits ---
//        Single.create { single in
//            let disposable = Disposables.create()
//
//            guard let path = Bundle.main.path(forResource: "fileName", ofType: "txt") else {
//                single(.error(FileReadError.FileReadError))
//                return disposable
//            }
//
//            guard let data = FileManager.default.contents(atPath: path) else {
//                single(.error(FileReadError.unreadable))
//                return disposable
//            }
//
//            guard let contents = String(data: data, encoding: .utf8) else {
//                single(.error(FileManager.encodingFailed))
//                return disposable
//            }
//
//            single(.success(contents))
//            return disposable
//        }
        
        // 1
//        loadText(from: "Copyright")
//            // 2
//            .subscribe {
//            // 3
//            switch $0 {
//            case .success(let string):
//            print(string)
//            case .error(let error):
//            print(error)
//            }
//            }
//            .disposed(by: disposeBag)
        
        
        // MARK: Subjects
//        let subject = PublishSubject<String>()
//
//        subject.onNext("is anything listening ?")
//
//        let subscriptionOne = subject
//            .subscribe(onNext: { (string) in
//                print(string)
//            }, onError: nil, onCompleted: nil, onDisposed: nil)
//
//        subject.on(.next("new element"))
//
//        subject.onNext("use onNext to emit")
        
        // 1. PublishSubject: Starts empty and only emits new elements to subscribers.
        
        
        // 2. BehaviorSubject: Starts with an initial value and replays it or the latest element to new subscribers.
        
        // 3. ReplaySubject: Initialized with a buffer size and will maintain a buffer of elements up to that size and replay it to new subscribers.
        
        // 4. AsyncSubject: Emits only the last .next event in the sequence, and only when the subject receives a .completed event. This is a seldom used kind of subject, and you won't use it in this book. It's listed here for the sake of completeness.
        
        // 5. PublishRelay and BehaviorRelay: These wrap their relative subjects, but only accept .next events. You cannot add a .completed or .error event onto relays at all, so they're great for non-terminating sequences.
//        
//        let subscriptionTwo = subject
//            .subscribe { event in
//                print("2)", event.element ?? event)
//        }
//        
//        subject.onNext("3")
//        
//        subscriptionOne.dispose()
//        
//        subject.onNext("4")
//        
//        subject.onCompleted()
//        
//        subject.onNext("5")
//        
//        subscriptionTwo.dispose()
//        
//        subject
//            .subscribe { print("3)", $0.element ?? $0 ) }
//            .disposed(by: disposeBag)
//        
//        subject.onNext("?")
    }
    
//    func loadText(from name: String) -> Single<String> {
//        return Single.create { single in
//                        let disposable = Disposables.create()
//
//                        guard let path = Bundle.main.path(forResource: "fileName", ofType: "txt") else {
//                            single(.error(FileReadError.FileReadError))
//                            return disposable
//                        }
//
//                        guard let data = FileManager.default.contents(atPath: path) else {
//                            single(.error(FileReadError.unreadable))
//                            return disposable
//                        }
//
//                        guard let contents = String(data: data, encoding: .utf8) else {
//                            single(.error(FileManager.encodingFailed))
//                            return disposable
//                        }
//
//                        single(.success(contents))
//                        return disposable
//        }
//    }


}
