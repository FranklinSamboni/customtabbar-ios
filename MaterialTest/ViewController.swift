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
        
    }

    func didSelectItem(customTabBar tabBar: CustomTabBar, item: UITabBarItem) {
        
    }
}

