//
//  CustomTabBar.swift
//  MaterialTest
//
//  Created by Franklin Samboni on 9/3/19.
//  Copyright © 2019 Franklin Samboni. All rights reserved.
//

import UIKit

protocol CustomTabBarDelegate: class {
    
    func didSelectItem(customTabBar tabBar: CustomTabBar, item: UITabBarItem)
}

class CustomTabBar: UIView {
    
    weak var delegate: CustomTabBarDelegate?
    fileprivate var collectionView: UICollectionView!
    
    var items: [UITabBarItem]! {
        didSet{
            collectionView.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }

    func initViews(){
        let cframe = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: cframe,collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CustomTabBarItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomTabBarItemCollectionViewCell")
        items = []
        
        collectionView.backgroundColor = .darkGray
        addSubview(collectionView)
        
        //self.backgroundColor = .darkGray
    }
    
}

extension CustomTabBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomTabBarItemCollectionViewCell", for: indexPath) as! CustomTabBarItemCollectionViewCell
        cell.setup(item: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.didSelectItem(customTabBar: self, item: items[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = items[indexPath.row]
        let size = NSString(string: item.title ?? "").size(withAttributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)
            ])
        return CGSize(width: size.width + 32 + 24 + 8, height: frame.height)
    }
    
}
