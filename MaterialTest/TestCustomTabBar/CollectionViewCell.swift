//
//  CollectionViewCell.swift
//  MaterialTest
//
//  Created by Franklin Samboni on 9/5/19.
//  Copyright © 2019 Franklin Samboni. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //textLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureCell(name: String) {
        self.textLabel.text = name
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.width = CGFloat(ceilf(Float(size.width)))
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }

}
