//
//  LoginViewController.swift
//  WordFlash
//
//  Created by Artemii Shabanov on 16.12.2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.layer.borderColor = (UIColor.white).cgColor
        passwordTextField.layer.borderColor = (UIColor.white).cgColor
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
