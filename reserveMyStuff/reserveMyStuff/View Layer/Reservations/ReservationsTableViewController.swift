//
//  ReservationsTableViewController.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import UIKit
import IoniconsSwift

class ReservationsTableViewController: UITableViewController, Storyboarded, Navigatable {
    static var storyboard: Storyboards = .main
    var navigation: ((Route, UIViewController?) -> Void)?
    
    enum Route {
        case none
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configUI()
    }
    
    // MARK: - Actions
    @objc private func addBtnPress() {
        print("hit")
        
    }
    
    // MARK: - Table view data source    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReservationTableViewCell", for: indexPath) as? ReservationTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

// MARK: - Private Methods
private extension ReservationsTableViewController {
    func configUI() {
        self.title = R.string.localizable.myReservations().uppercased()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.barTintColor = R.color.babyBlue()

        let addBtnItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnPress))
        addBtnItem.tintColor = .white
        navigationItem.rightBarButtonItem = addBtnItem
        
        let reservationNib = UINib(nibName: "ReservationTableViewCell", bundle: nil)
        self.tableView.register(reservationNib, forCellReuseIdentifier: "ReservationTableViewCell")
        self.tableView.backgroundColor = R.color.offWhite()
    }
}
