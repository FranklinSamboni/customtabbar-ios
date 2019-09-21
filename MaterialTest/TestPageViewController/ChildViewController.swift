//
//  ChildViewController.swift
//  MaterialTest
//
//  Created by Franklin Samboni on 9/21/19.
//  Copyright © 2019 Franklin Samboni. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    
    var number = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = String(number+1) 
    }

}
