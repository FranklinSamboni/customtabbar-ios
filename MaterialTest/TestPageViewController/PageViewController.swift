//
//  PageViewController.swift
//  MaterialTest
//
//  Created by Franklin Samboni on 9/21/19.
//  Copyright © 2019 Franklin Samboni. All rights reserved.
//

import UIKit

protocol PageViewControllerItemDelegate {
    func scrolledIndex(index: Int)
}

class PageViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    var tabs = [String]()
    var itemsDelegate : PageViewControllerItemDelegate?
    var disableScrollBounce = false
    
    var currentIndex = 0 {
        didSet{
            if currentIndex == 0 {
                disableScrollBounce = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        setupPages()
        setupGestures()
        
        for subview in self.view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.delegate = self
                break;
            }
        }
    }
    
    func setupPages(){
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        for (i,_) in tabs.enumerated(){
            let v = storyBoard.instantiateViewController(withIdentifier: "ChildViewController") as! ChildViewController
            v.number = i
            pages.append(v)
        }
        
        if let first = pages.first{
            currentIndex = 0
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
    func setupGestures(){
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        gesture.maximumNumberOfTouches = 1
        gesture.minimumNumberOfTouches = 1
        gesture.delegate = self
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer){
        
        let velocidad = gesture.velocity(in: gesture.view!.superview!)
        let validation = velocidad.x > 0 && abs(velocidad.y) <= 1000
        if validation{
            switch gesture.state{
            case .began:
                //enableScrollView(view: self.view, enable: false)
                break
            case .ended:
                //enableScrollView(view: self.view, enable: true)
                break
            case .possible:
                break
            case .changed:
                //enableScrollView(view: self.view, enable: false)
                break
            case .cancelled:
                break
            case .failed:
                
                break
            @unknown default:
                break
            }
        }else{
            //print("handlePanGesture not called")
            
            enableScrollView(view: self.view, enable: true)
        }
        print("handlePanGesture velocidad.x: \(velocidad.x) velocidad.y: \(velocidad.y)")
    }
    
    func enableScrollView(view: UIView, enable: Bool){
        for v in view.subviews{
            if let scrollView = v as? UIScrollView{
                scrollView.isScrollEnabled = enable
            }
        }
    }
}

extension PageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = index - 1
        guard previousIndex >= 0 else { return nil }
        
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
    
        guard nextIndex < pages.count else { return nil }
        guard pages.count > nextIndex else { return nil         }
        
        return pages[nextIndex]
        
    }
}

extension PageViewController: UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if finished && completed {
            if let first = pageViewController.viewControllers?.first,
                let index = pages.firstIndex(of: first) {
                currentIndex = index
                itemsDelegate?.scrolledIndex(index: index)
            }
        }
    }
}

extension PageViewController: UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        let current = viewControllers?.first
        let index = pages.firstIndex(of: current!)
        if index == 0 {
            return true
        }
        return false
    }
}

extension PageViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(disableScrollBounce && currentIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width){
            
            scrollView.contentOffset = CGPoint(x:scrollView.bounds.size.width, y:0.0)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(disableScrollBounce  && currentIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width){
            
            scrollView.contentOffset = CGPoint(x:scrollView.bounds.size.width, y:0.0)
        }
    }
}
