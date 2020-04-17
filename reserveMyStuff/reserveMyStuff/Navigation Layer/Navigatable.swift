//
//  Navigatable.swift
//  canWeCoodinate
//
//  Created by Josh Franco on 3/28/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import UIKit

/// Classes that conform to this protocol can be navigated by a coordinator
/// Normal use case of this protocol ex:
/// 1) make a enum of exits and make 'navResult' equal to that enum
/// 2) use the navigation completion to drive the the classes navigation via a coordinator
/// 3) define what the class will do in the coordinator via the navigation completion
protocol Navigatable: class {
    associatedtype navResult
    /// Completion used to control the navigation
    var navigation: ((navResult, UIViewController?) -> Void)? { get set }
}

extension Navigatable where Self: UIViewController {
    /// Navigates to the route based on the navResult (for the parent to navigate the child)
    func navigate(_ result: navResult) {
        navigation?(result, self)
    }
    
    func startNavigation(completion onNav: @escaping (navResult, UIViewController?) -> Void) {
        self.navigation = onNav
    }
    
}

extension Navigatable where Self: Coordinator {
    /// Navigates to the route based on the navResult (for the parent to navigate the child)
    func navigate(_ result: navResult) {
        navigation?(result, self.rootViewController)
    }
    
    func startNavigation(completion onNav: @escaping (navResult, Coordinator) -> Void) {
        self.navigation = { [weak self] result, _ in
            guard let self = self else { return }
            
            onNav(result, self)
        }
    }
}
