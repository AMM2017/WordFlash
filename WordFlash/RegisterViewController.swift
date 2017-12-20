//
//  RegisterViewController.swift
//  WordFlash
//
//  Created by Artemii Shabanov on 19.12.2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, NetworkDelegate {
    func didReceiveToken(token: String?) {
        //pass
    }
    
    func didRegisterUser(register flag: Bool) {
        print("register: \(flag)")
    }
    
    func didReceiveWords() {
        //pass
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didButtonOkPressed(_ sender: Any) {
        let manager = NetworkManager()
        manager.delegate = self
        
        var user = NetworkUser()
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        
        manager.register(user)
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
}

