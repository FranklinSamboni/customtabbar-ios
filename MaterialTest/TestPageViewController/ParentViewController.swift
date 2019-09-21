//
//  PageViewController.swift
//  MaterialTest
//
//  Created by Franklin Samboni on 9/21/19.
//  Copyright © 2019 Franklin Samboni. All rights reserved.
//

import UIKit
import MaterialComponents

class ParentViewController: UIViewController {

    @IBOutlet weak var topTabBar: MDCTabBar!
    private var pageViewController: PageViewController?
    
    var items = ["Primer", "Segundo", "Tercero", "Cuarto", "Quinto", "Sexto", "Septimo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTopTabBar()
        setupPageView()
    }

    func setupTopTabBar(){
        topTabBar.delegate = self
        topTabBar.alignment = .center
        topTabBar.itemAppearance = .titles
        topTabBar.unselectedItemTintColor = .gray
        topTabBar.selectedItemTintColor = .darkGray
        topTabBar.tintColor = .gray
        topTabBar.barTintColor = .lightGray
        for (i,item) in items.enumerated(){
            topTabBar.items.append(UITabBarItem(title: item, image: nil, tag: i))
        }
    }

    func setupPageView(){
        guard let pageView = children.first as? PageViewController
            else{
            print("PageViewController doesn't exits")
            return
        }
        
        self.pageViewController = pageView
        self.pageViewController?.itemsDelegate = self
        self.pageViewController?.tabs = items
        self.pageViewController?.setupPages()
    }
    
    func selectPageForIndex(index: Int){
        let nextPage = self.pageViewController?.pages[index]
        let currentPage = self.pageViewController?.viewControllers?.first
        let currentIndex = self.pageViewController?.pages.firstIndex(of: currentPage!)
        
        self.pageViewController?.setViewControllers([nextPage!], direction: index > currentIndex! ? .forward : .reverse, animated: true, completion: { (finished) in
            if finished{
                self.pageViewController?.currentIndex = index
            }
        })
        
    }
    
    func selectTabForIndex(index: Int){
        let item = topTabBar.items[index]
        topTabBar.setSelectedItem(item, animated: true)
    }
}

extension ParentViewController: MDCTabBarDelegate{
    func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
        selectPageForIndex(index: item.tag)
    }
}

extension ParentViewController: PageViewControllerItemDelegate{
    func scrolledIndex(index: Int) {
        selectTabForIndex(index: index)
    }
}
