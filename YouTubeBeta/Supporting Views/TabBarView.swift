//
//  TabBarView.swift
//  YouTubeBeta
//
//  Created by NEKA on 8/23/19.
//  Copyright © 2019 NEKA. All rights reserved.
//

import UIKit

class TabBarView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var whiteBar: UIView!
    @IBOutlet weak var whiteBarLeadingConstraint: NSLayoutConstraint!
    private let tabBarImages = ["home", "trending", "subscriptions", "account"]
    var selectedIndex = 0
    
    //MARK: Methods
    func customization() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor(white: 0, alpha: 0)
        self.backgroundColor = UIColor.rgb(r: 228, g: 34, b: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tabBarImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TabBarCellCollectionViewCell
        let imageName = self.tabBarImages[indexPath.row]
        cell.icon.image = UIImage.init(named: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.collectionView.bounds.width / 4, height: self.collectionView.bounds.height)
    }
    
    //MARK: View Life-cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customization()
    }
    
}

class TabBarCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var icon: UIImageView!
}
