//
//  ViewController.swift
//  WordFlash
//
//  Created by Alexandr on 26/11/2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import UIKit
import RealmSwift
import Koloda
import paper_onboarding

class ViewController: UIViewController{
    let onboarding = PaperOnboarding(itemsCount: 3)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

