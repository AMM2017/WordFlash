//
//  LoginViewController.swift
//  WordFlash
//
//  Created by Artemii Shabanov on 16.12.2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, NetworkDelegate {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.layer.borderColor = (UIColor.white).cgColor
        passwordTextField.layer.borderColor = (UIColor.white).cgColor
        spinner.isHidden = true
    }
    
    /*@IBAction func loginTextChanged(_ sender: Any) {
        if loginTextField.text != "" {
            loginTextField.layer.borderColor = (UIColor.white).cgColor
        }
    }
    
    @IBAction func passTextChanged(_ sender: Any) {
        if passwordTextField.text != "" {
            passwordTextField.layer.borderColor = (UIColor.white).cgColor
        }
    }*/
    
    //MARK: custom
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func okButtonPressed(_ sender: Any) {
        if loginTextField.text == "" {
            loginTextField.shake()
            return
        }
        if passwordTextField.text == "" {
            passwordTextField.shake()
            return
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
    
    
    //MARK: animation
    
    func startLoadingAnimation() {
        loginTextField.isEnabled = false
        passwordTextField.isEnabled = false
        createButton.isEnabled = false
        okButton.isEnabled = false
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func stopLoadingAnimation() {
        spinner.isHidden = true
        spinner.stopAnimating()
        loginTextField.isEnabled = true
        passwordTextField.isEnabled = true
        createButton.isEnabled = true
        okButton.isEnabled = true
    }
    
    
    //MARK: Networkmanager
    
    func didReceiveToken(token: String?) {
        stopLoadingAnimation()
        if token == nil {
            defaults.set(token, forKey: "Token")
            defaults.set(loginTextField.text, forKey: "Username")
            self.dismiss(animated: false, completion: nil)
        } else {
            loginTextField.layer.borderColor = (UIColor.red).cgColor
            loginTextField.shake()
            passwordTextField.layer.borderColor = (UIColor.red).cgColor
            passwordTextField.shake()
        }
    }
    
    func didRegisterUser(register flag: Bool) {
        print("register")
    }
    
    func didReceiveWords() {
        print("words")
    }
    
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-15.0, 15.0, -15.0, 15.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}








