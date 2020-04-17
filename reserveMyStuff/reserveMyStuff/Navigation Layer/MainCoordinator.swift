//
//  MainCoordinator.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator, Navigatable {
    var services: SomeServices?
    var parent: Coordinator?
    var children: [Coordinator] = []
    
    var window: UIWindow?
    var navigation: ((Route, UIViewController?) -> Void)?
    weak var rootViewController: UIViewController? {
        didSet {
            window?.rootViewController = self.rootViewController
            window?.makeKeyAndVisible()
        }
    }
    
    enum Route {
        case done
    }
    
    convenience init(within window: UIWindow?, with services: SomeServices?) {
        self.init(with: services)
        
        self.window = window
    }
    
    func start() {
        let reservationsVC = ReservationsTableViewController.instantiate()
        let navController = UINavigationController(rootViewController: reservationsVC)
        self.rootViewController = navController
        
        reservationsVC.startNavigation { (result, coord) in
            switch result {
            case .none:
                // do stuff
                break
            }
        }
    }
    
    deinit {
        print("👏\(String(describing: type(of: self)))👏")
    }
}
