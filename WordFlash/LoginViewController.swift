//
//  LoginViewController.swift
//  WordFlash
//
//  Created by Artemii Shabanov on 16.12.2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, NetworkDelegate {
    
    func didReceiveToken(token: String?) {
        stopLoadingAnimation()
        print(token)
    }
    
    func didRegisterUser(register flag: Bool) {
        print("register")
    }
    
    func didReceiveWords() {
        print("words")
    }
    
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.layer.borderColor = (UIColor.white).cgColor
        passwordTextField.layer.borderColor = (UIColor.white).cgColor
    }
    
    @IBAction func okButtonPressed(_ sender: Any) {
        if loginTextField.text = "" {
            loginTextField.layer.borderColor = (UIColor.yellow).cgColor
        }
        if passwordTextField.text = "" {
            passwordTextField.layer.borderColor = (UIColor.yellow).cgColor
        }
        loginTextField.layer.borderColor = (UIColor.white).cgColor
        passwordTextField.layer.borderColor = (UIColor.white).cgColor
        
        var user = NetworkUser()
        user.username = loginTextField.text!
        user.password = passwordTextField.text!
        
        let manager = NetworkManager()
        manager.delegate = self
        manager.token(from: user)
        startLoadingAnimation()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func startLoadingAnimation() {
        
    }
    
    func stopLoadingAnimation() {
        
    }
}








