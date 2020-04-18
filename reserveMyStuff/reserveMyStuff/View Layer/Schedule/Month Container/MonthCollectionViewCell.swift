//
//  MonthCollectionViewCell.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import UIKit

protocol MonthCollectionViewCellDelegate: class {
    func monthUpdated(with monthStr: String)
}

class MonthCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var dayOfMonthLabel: UILabel!
    @IBOutlet var isSelectedViews: [UIView]!
    
    weak var delegate: MonthCollectionViewCellDelegate?
    private var currentMonth = "?" {
        didSet {
            guard self.currentMonth != oldValue else { return }
            self.delegate?.monthUpdated(with: self.currentMonth)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.isSelectedViews.forEach { $0.isHidden = false }
            } else {
                self.isSelectedViews.forEach { $0.isHidden = true }
            }
        }
    }
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.borderColor = R.color.textGray()?.cgColor
        self.contentView.layer.borderWidth = 0.5
    }
    
    // MARK: - Util Methods
    func config(using date: Date) {
        let formatter = DateFormatter()
        let month = Calendar.current.component(.month, from: date)
        let weekday = Calendar.current.component(.weekday, from: date)
        let day = Calendar.current.component(.day, from: date)

        self.currentMonth = formatter.monthSymbols[month - 1]
        
        dayOfWeekLabel.text = formatter.weekdaySymbols[weekday - 1]
        dayOfMonthLabel.text = "\(day)"
    }
}
