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
import SwiftyJSON
import Alamofire


let shippedVersion = 5

public enum Keys: String {
    case lastCachedVersion = "Keys.lastCachedVersion"
    , wasLaunchedOnce = "Keys.wasL"
}
class ViewController: UIViewController{
    let onboarding = PaperOnboarding(itemsCount: 3)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(5, forKey: Keys.lastCachedVersion.rawValue)
        
        userDefaults.synchronize()
        
        userDefaults.integer(forKey: Keys.lastCachedVersion.rawValue)
        
        if userDefaults.bool(forKey: Keys.wasLaunchedOnce.rawValue) {
            // show onboarding
            // .com/lastVersion
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

