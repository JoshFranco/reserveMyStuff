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
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var partySizeTextField: UITextField!
    @IBOutlet weak var reservationImageView: UIImageView!
    @IBOutlet weak var reservationTitleLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var partySizeLabel: UILabel!
    
    static var storyboard: Storyboards = .main
    var navigation: ((Route, UIViewController?) -> Void)?
    
    private var reservation: ReservationOption?
    private var durationPicker = UIPickerView()
    private var partySizePicker = UIPickerView()
    private var pickerDuraitonValue = ""
    private var pickerPartySizeValue = ""
    
    enum Route {
        case back
        case reserve
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configUI()
        self.configTextFields()
    }
    
    deinit {
        print("👏\(String(describing: type(of: self)))👏")
    }
    
    // MARK: - Actions
    @objc private func backBtnPress() {
        self.navigate(.back)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func doneWithDuration() {
        durationTextField.text = self.pickerDuraitonValue
        view.endEditing(true)
    }
    
    @objc private func doneWithPartySize() {
        partySizeTextField.text = self.pickerPartySizeValue
        view.endEditing(true)
    }
    
    @IBAction func reservationBtnPress(_ sender: Any) {
        self.navigate(.reserve)
    }
    
    // MARK: - Util Methods
    func config(using reservation: ReservationOption) {
        self.reservation = reservation
        
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
        
        self.partySizeTextField.layer.borderColor = UIColor.systemBlue.cgColor
        self.partySizeTextField.layer.borderWidth = 1
        self.partySizeTextField.layer.cornerRadius = 5
        self.partySizeLabel.text = R.string.localizable.partySize()
        
        if let reservation = self.reservation {
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            currencyFormatter.locale = Locale.current
            let dollars = Double(reservation.price) / 100
            self.costLabel.text = currencyFormatter.string(from: NSNumber(value: dollars))
            
            self.reservationTitleLabel.text = reservation.title
            self.descriptionLabel.text = reservation.description
            self.partySizeTextField.text = "1"
            
            if let firstDurationOption = reservation.durationOptions.first {
                let firstOption = R.string.localizable.hours("\(Int(firstDurationOption))")
                self.durationTextField.text = firstOption
            }
        }
    }
    
    func configTextFields() {
        self.durationPicker.dataSource = self
        self.durationPicker.delegate = self
        self.partySizePicker.dataSource = self
        self.partySizePicker.delegate = self
        
        self.durationTextField.delegate = self
        self.durationTextField.inputView = durationPicker
        self.durationTextField.tintColor = .clear
        self.partySizeTextField.delegate = self
        self.partySizeTextField.inputView = partySizePicker
        self.partySizeTextField.tintColor = .clear
        
        let durationBar = UIToolbar()
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissKeyboard))
        cancelBtn.tintColor = .lightGray
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneWithDuration))
        durationBar.items = [cancelBtn, spacer, doneBtn]
        durationBar.sizeToFit()
        self.durationTextField.inputAccessoryView = durationBar
        
        let partySizeBar = UIToolbar()
        let cancelPartySizeBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissKeyboard))
        cancelPartySizeBtn.tintColor = .lightGray
        let doneWithPartySizeBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneWithPartySize))
        partySizeBar.items = [cancelPartySizeBtn, spacer, doneWithPartySizeBtn]
        partySizeBar.sizeToFit()
        self.partySizeTextField.inputAccessoryView = partySizeBar
    }
}

// MARK: - UIPickerViewDataSource
extension ScheduleViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case self.durationPicker:
            return self.reservation?.durationOptions.count ?? 0
        case self.partySizePicker:
            return 12
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case self.durationPicker:
            guard let duration = self.reservation?.durationOptions[row] else { return nil }
            return R.string.localizable.hours("\(Int(duration))")
        case self.partySizePicker:
            return "\(row + 1)"
        default:
            return nil
        }
        
    }
}

// MARK: - UIPickerViewDelegate
extension ScheduleViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case self.durationPicker:
            guard let duration = self.reservation?.durationOptions[row] else { break }
            self.pickerDuraitonValue = R.string.localizable.hours("\(Int(duration))")
        case self.partySizePicker:
            self.pickerPartySizeValue = "\(row + 1)"
        default: break
        }
    }
}

// MARK: - UITextFieldDelegate
extension ScheduleViewController: UITextFieldDelegate {
}
