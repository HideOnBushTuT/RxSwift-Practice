//
//  SubjectsViewController.swift
//  RxSwiftTest
//
//  Created by CBReno on 2019/6/25.
//  Copyright © 2019 CBReno. All rights reserved.
//

import UIKit
import RxSwift

enum MyError: Error {
    case anError
}

class SubjectsViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        hehaviorSubjects()
    }
    
    func prints<T: CustomStringConvertible>(label: String, event: Event<T>) {
        print("\(label), \(event.element)")
//        print(label, event: (event.element ?? event.error) ?? event)
    }
    
    func hehaviorSubjects() {
        /**
         “Behavior subjects are useful when you want to pre-populate a view with the most recent data. For example, you could bind controls in a user profile screen to a behavior subject, so that the latest values can be used to pre-populate the display while the app fetches fresh data.
         But what if you wanted to show more than the latest value? For example, on a search screen, you may want to show the most recent five search terms used. This is where replay subjects come in.”
         
        */
        let subject = BehaviorSubject(value: "Initial value")
        
        subject
            .subscribe {
                self.prints(label: "1): \($0.element)", event: $0)
            }
            .disposed(by: disposeBag)
        
        subject.onNext("X Men")
        
        subject.onError(MyError.anError)
        
        subject
            .subscribe {
                self.prints(label: "2)", event: $0)
            }
            .disposed(by: disposeBag)
        
        
        
    }

}
