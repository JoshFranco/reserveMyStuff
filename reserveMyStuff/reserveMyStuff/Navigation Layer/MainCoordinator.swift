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
        
        reservationsVC.startNavigation { [weak self] (result, coord) in
            switch result {
            case .add:
                self?.startScheduleVC()
            }
        }
    }
    
    deinit {
        print("👏\(String(describing: type(of: self)))👏")
    }
}

private extension MainCoordinator {
    func startScheduleVC() {
        let scheduleVC = ScheduleViewController.instantiate()
        
        if let navController = rootViewController as? UINavigationController {
            navController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        self.navigate(to: scheduleVC) { (result, owner) in
            switch result {
            case .reserve:
                owner?.navigationController?.popViewController(animated: true)
            case .back:
                owner?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
