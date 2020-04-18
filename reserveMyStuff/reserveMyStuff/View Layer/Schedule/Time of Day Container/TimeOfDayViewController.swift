//
//  TimeOfDayViewController.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import UIKit

class TimeOfDayViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    

}

// MARK: - Private Methods
private extension TimeOfDayViewController {
    func configUI() {
        let nib = UINib(nibName: "TimeOfDayCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "TimeOfDayCollectionViewCell")
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 120, height: 360)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension TimeOfDayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeOfDayCollectionViewCell", for: indexPath) as? TimeOfDayCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}
