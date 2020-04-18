//
//  MonthViewController.swift
//  reserveMyStuff
//
//  Created by Josh Franco on 4/17/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import UIKit

class MonthViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
}

// MARK: - Private Methods
private extension MonthViewController {
    func configUI() {
        let nib = UINib(nibName: "MonthCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "MonthCollectionViewCell")
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 75, height: 120)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MonthViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCollectionViewCell", for: indexPath) as? MonthCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}
