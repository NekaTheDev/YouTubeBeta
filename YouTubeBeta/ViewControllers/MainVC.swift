//
//  MainVC.swift
//  YouTubeBeta
//
//  Created by NEKA on 8/23/19.
//  Copyright © 2019 NEKA. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    //MARK: Properties
    @IBOutlet var tabBarView: TabBarView!
    @IBOutlet weak var collectionView: UICollectionView!
    var views = [UIView]()
    
    //MARK: Methods
    func customization() {
        self.view.backgroundColor = UIColor.rgb(r: 228, g: 34, b: 24)
        
        // CollectionView Setup
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        //self.collectionView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        self.collectionView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view.bounds.height)
        
        //TableView Setup
        self.view.addSubview(self.tabBarView)
        self.tabBarView.translatesAutoresizingMaskIntoConstraints = false
        guard let v = self.view else { return }
        let _ = NSLayoutConstraint.init(item: v.safeAreaLayoutGuide, attribute: .top, relatedBy: .equal, toItem: self.tabBarView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: v, attribute: .left, relatedBy: .equal, toItem: self.tabBarView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: v, attribute: .right, relatedBy: .equal, toItem: self.tabBarView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        self.tabBarView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        //ViewController Init
        let viewControllers = [UIViewController(), UIViewController(), UIViewController(), UIViewController()]
        for vc in viewControllers {
            self.addChild(vc)
            vc.didMove(toParent: self)
            vc.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: (self.view.bounds.height - 44))
            self.views.append(vc.view)
        }
        self.collectionView.reloadData()
        
        //NotificationCenter Setup
        NotificationCenter.default.addObserver(self, selector: #selector(self.scrollViews(notification:)), name: .init(rawValue: "didSelectMenu"), object: nil)
    }
    
    @objc func scrollViews(notification: Notification) {
        if let info = notification.userInfo {
            let userInfo = info as! [String: Int]
            self.collectionView.scrollToItem(at: IndexPath.init(row: userInfo["index"]!, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollIndex = scrollView.contentOffset.x / self.view.bounds.width
        NotificationCenter.default.post(name: .init(rawValue: "scrollMenu"), object: nil, userInfo: ["length": scrollIndex])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.views.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.contentView.addSubview(self.views[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: (self.collectionView.bounds.height + 22))
    }
    
}
