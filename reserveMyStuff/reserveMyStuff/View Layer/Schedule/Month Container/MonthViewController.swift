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
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calBtn: UIButton!
    
    var dates: [Date] = []
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configData()
    }
    
    // MARK: - Actions
    @IBAction func calBtnPress(_ sender: Any) {
        showAlert()
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
        
        self.calBtn.setTitle(R.string.localizable.viewCalendar(), for: .normal)
    }
    
    func configData() {
        var indexDate = Date()
        
        for _ in 1...30 {
            dates.append(indexDate)
            if let newDate = indexDate.adding(.day, 1) {
                indexDate = newDate
            } else {
                break
            }
        }
        
        collectionView.reloadData()
    }
}

// MARK: - Private Methods
private extension MonthViewController {
    func showAlert() {
        let alert = UIAlertController(title: R.string.localizable.error(),
                                      message: "De-scoped due to time constraint",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok...", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension MonthViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCollectionViewCell", for: indexPath) as? MonthCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        cell.config(using: dates[indexPath.row])
        
        return cell
    }
}

extension MonthViewController: MonthCollectionViewCellDelegate {
    func monthUpdated(with monthStr: String) {
        self.monthLabel.text = monthStr
    }
}
