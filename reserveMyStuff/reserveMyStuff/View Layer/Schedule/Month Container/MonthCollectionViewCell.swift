//
//  MonthCollectionViewCell.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import UIKit

class MonthCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.borderColor = R.color.textGray()?.cgColor
        self.contentView.layer.borderWidth = 0.5
    }

}
