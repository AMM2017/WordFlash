//
//  HistoryWordViewController.swift
//  WordFlash
//
//  Created by Artemii Shabanov on 02.12.2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import UIKit


class HistoryWordViewController: UIViewController {
    
    var word:Word?
    
    @IBOutlet weak var definition: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    
    //yep
    override func viewDidLoad() {
        super.viewDidLoad()
        wordLabel.text = word?.word
        definition.text = word?.defenition

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //custom button
    @IBAction func back(_ sender: Any) {
        try! realm.write{
            word?.defenition = definition.text!
        }
        self.dismiss(animated: true, completion: nil)
    }
}
