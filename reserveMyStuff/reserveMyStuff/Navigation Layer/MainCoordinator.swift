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
    weak var mainVC: UIViewController?
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
        self.mainVC = reservationsVC
        self.rootViewController = navController
        
        reservationsVC.startNavigation { [weak self] (result, coord) in
            switch result {
            case .add:
                self?.startOptionsVC()
            }
        }
    }
    
    deinit {
        print("👏\(String(describing: type(of: self)))👏")
    }
}

private extension MainCoordinator {
    func startOptionsVC() {
        let optionsVC = OptionsTableViewController.instantiate()
        
        self.navigate(to: optionsVC) { [weak self] (result, owner) in
            switch result {
            case .optionSelected(let reservation):
                self?.startScheduleVC(with: reservation)
            case .back:
                owner?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func startScheduleVC(with reservation: ReservationOption) {
        let scheduleVC = ScheduleViewController.instantiate()
        scheduleVC.config(using: reservation)
        
        self.navigate(to: scheduleVC) { (result, owner) in
            switch result {
            case .reserve:
                if let mainVC = self.mainVC {
                    owner?.navigationController?.popToViewController(mainVC, animated: true)
                }
            case .back:
                owner?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
