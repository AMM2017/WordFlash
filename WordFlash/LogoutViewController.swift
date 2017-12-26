//
//  LogoutViewController.swift
//  WordFlash
//
//  Created by Artemii Shabanov on 26.12.2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController {
    
    @IBOutlet weak var nickname: UILabel!
    
    
    @IBAction func logout(_ sender: Any) {
        
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
