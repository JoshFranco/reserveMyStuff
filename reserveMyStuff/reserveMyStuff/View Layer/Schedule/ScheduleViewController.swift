//
//  ScheduleViewController.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import UIKit
import IoniconsSwift

class ScheduleViewController: UIViewController, Storyboarded, Navigatable {
    
    @IBOutlet weak var partySizeBtn: UIButton!
    
    static var storyboard: Storyboards = .main
    var navigation: ((Route, UIViewController?) -> Void)?
    
    enum Route {
        case back
        case reserve
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
    }
    
    deinit {
        print("👏\(String(describing: type(of: self)))👏")
    }
    
    // MARK: - Actions
    @objc private func backBtnPress() {
        self.navigate(.back)
    }
}

// MARK: - Private Methods
private extension ScheduleViewController {
    func configUI() {
        self.title = R.string.localizable.schedule().uppercased()
        
        self.navigationItem.hidesBackButton = true
        let backBtn = UIBarButtonItem(image: Ionicons.chevronLeft.image(28),
                                      style: .plain,
                                      target: self,
                                      action: #selector(backBtnPress))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
        
        self.partySizeBtn.layer.borderColor = UIColor.systemBlue.cgColor
        self.partySizeBtn.layer.borderWidth = 1
        self.partySizeBtn.layer.cornerRadius = 5
    }
}
