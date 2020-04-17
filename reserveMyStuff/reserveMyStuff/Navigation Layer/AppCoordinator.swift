//
//  AppCoordinator.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    var services: SomeServices?
    var parent: Coordinator?
    var children: [Coordinator] = []
    
    var window: UIWindow?
    var rootViewController: UIViewController? {
        didSet {
            window?.rootViewController = self.rootViewController
            window?.makeKeyAndVisible()
        }
    }
    
    convenience init(within window: UIWindow?, with services: SomeServices?) {
        self.init(with: services)
        
        self.window = window
    }
    
    func start() {
        if 2 > 0 {
            startMainCoord()
        } else {
            /// If we where to have a somthing login flow (or maybe a diff landing view) this is where we would
            /// set that up. for now it will default to just the main flow
        }
    }
}

private extension AppCoordinator {
    func startMainCoord() {
        let mainCoord = MainCoordinator(within: window, with: services)
        self.addChild(mainCoord)
        
        mainCoord.start { (result, _) in
            switch result {
            case .done:
                /// For this proj we do not NEED the main coord to be navigated but this is to show that
                /// a coordinator can be navigated just like a view controller. This will also allow the parent to control the child
                break
            }
        }
    }
}
