//
//  ViewController.swift
//  MaterialTest
//
//  Created by Franklin Samboni on 9/3/19.
//  Copyright © 2019 Franklin Samboni. All rights reserved.
//

import UIKit
import MaterialComponents

class ViewController: UIViewController, MDCTabBarDelegate, CustomTabBarDelegate {

    @IBOutlet weak var topTabBar: MDCTabBar!
    @IBOutlet weak var customTabBar: CustomTabBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var names = ["Anders", "Kristian", "Sofia", "John", "Jenny", "Lina", "Annie", "Katie", "Johanna"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "icon")
        let firstItem = UITabBarItem(title: "Example asdasdasd asdasdd1", image: image, tag: 0)
        let secondItem = UITabBarItem(title: "Example1", image: image, tag: 1)
        let thirdItem = UITabBarItem(title: "Example1", image: image, tag: 2)
        let fourthItem = UITabBarItem(title: "Example1", image: image, tag: 3)
        let fifthItem = UITabBarItem(title: "Example1", image: image, tag: 4)
        
        
        topTabBar.items.append(firstItem)
        topTabBar.items.append(secondItem)
        topTabBar.items.append(thirdItem)
        topTabBar.items.append(fourthItem)
        topTabBar.items.append(fifthItem)
        
        topTabBar.backgroundColor  = .blue
        topTabBar.itemAppearance = .titledImages
        topTabBar.alignment = .center
        topTabBar.displaysUppercaseTitles = true
        topTabBar.delegate = self
        
        customTabBar.delegate = self
        customTabBar.items.append(firstItem)
        customTabBar.items.append(secondItem)
        customTabBar.items.append(thirdItem)
        customTabBar.items.append(fourthItem)
        customTabBar.items.append(fifthItem)
        
        registerNib()
        //collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 1.0
            flowLayout.minimumInteritemSpacing = 1.0
            // note: since the labels are "auto-width-stretching", the height here defines the actual height of the cells
            //flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
    }

    func didSelectItem(customTabBar tabBar: CustomTabBar, item: UITabBarItem) {
        
    }
    
    func registerNib() {
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCellReusable")
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 100, height: 48)
        }
        
        
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellReusable",for: indexPath) as? CollectionViewCell {
            let name = names[indexPath.row]
            cell.configureCell(name: name)
            return cell
        }
        return UICollectionViewCell()
    }
}



