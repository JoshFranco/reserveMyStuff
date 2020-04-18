//
//  TimeOfDayCollectionViewCell.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import UIKit

class TimeOfDayCollectionViewCell: UICollectionViewCell {
    @IBOutlet var allCells: [UIView]!
    @IBOutlet weak var firstCell: UIView!
    @IBOutlet weak var secondCell: UIView!
    @IBOutlet weak var thirdCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for cell in allCells {
            cell.layer.borderColor = R.color.textGray()?.cgColor
            cell.layer.borderWidth = 0.5
        }
    }

}
