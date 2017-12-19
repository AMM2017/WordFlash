//
//  RegisterViewController.swift
//  WordFlash
//
//  Created by Artemii Shabanov on 19.12.2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var firstPasswordTextField: UITextField!
    @IBOutlet weak var secondPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.layer.borderColor = (UIColor.white).cgColor
        loginTextField.layer.borderColor = (UIColor.white).cgColor
        firstPasswordTextField.layer.borderColor = (UIColor.white).cgColor
        secondPasswordTextField.layer.borderColor = (UIColor.white).cgColor        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

