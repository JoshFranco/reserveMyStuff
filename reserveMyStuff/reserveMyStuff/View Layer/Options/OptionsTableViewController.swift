//
//  OptionsTableViewController.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import UIKit
import IoniconsSwift

class OptionsTableViewController: UITableViewController, Storyboarded, Navigatable {
    static var storyboard: Storyboards = .main
    var navigation: ((Route, UIViewController?) -> Void)?
    var options: [ReservationOption] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    enum Route {
        case optionSelected(reservation: ReservationOption)
        case back
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
        self.configData()
    }
    
    // MARK: - Actions
    @objc private func backBtnPress() {
        self.navigate(.back)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.navigate(.optionSelected(reservation: options[indexPath.row]))
        
    }
}

// MARK: - Private Methods
private extension OptionsTableViewController {
    func configUI() {
        self.title = R.string.localizable.reservationOptions().uppercased()
        
        self.navigationItem.hidesBackButton = true
        let backBtn = UIBarButtonItem(image: Ionicons.chevronLeft.image(28),
                                      style: .plain,
                                      target: self,
                                      action: #selector(backBtnPress))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn

        self.tableView.backgroundColor = R.color.offWhite()
    }
    
    func configData() {
        ReservationService.shared.getMostCurrentOptions { [weak self] result in
            switch result {
            case .success(let newOptions):
                self?.options = newOptions
            case .failure(let error):
                self?.showAlert(with: error.localizedDescription)
            }
        }
    }
    
    func showAlert(with msg: String) {
        let alert = UIAlertController(title: R.string.localizable.error(),
                                      message: msg,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok...", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
