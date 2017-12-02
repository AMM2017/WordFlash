//
//  ShowWordDescroptionViewController.swift
//  WordFlash
//
//  Created by Alexandr on 02/12/2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import UIKit

class ShowWordDescroptionViewController: UIViewController {

    var word = ""
    var descript = ""
    
    
    @IBOutlet weak var wordText: UITextView!
    @IBOutlet weak var descrTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        wordText.text = word
        descrTextField.text = descript
    }
    @IBAction func buttonPressed(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
