//
//  CustomTabBarItemCollectionViewCell.swift
//  MaterialTest
//
//  Created by Franklin Samboni on 9/3/19.
//  Copyright © 2019 Franklin Samboni. All rights reserved.
//

import UIKit

class CustomTabBarItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(item: UITabBarItem){
        itemTitleLabel.text = item.title
        itemImageView.image = item.image
    }
}
