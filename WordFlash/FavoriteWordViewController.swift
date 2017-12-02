//
//  FavoriteWordViewController.swift
//  RealmTemplate
//
//  Created by xcode on 25.11.2017.
//  Copyright © 2017 Andrey Volodin. All rights reserved.
//
import UIKit

class FavoriteWordViewController: UIViewController {
    
    var word:Word?
    @IBOutlet weak var starButton: UIButton!
    
    @IBOutlet weak var definition: UITextView!
    @IBOutlet weak var wordLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        wordLabel.text = word?.word
        definition.text = word?.defenition
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    @IBAction func starPressed(_ sender: Any) {
        if word!.isFavorite {
            starButton.setTitleColor(.gray, for: .normal)
            try! realm.write {
                word?.isFavorite = false
            }
        }
        else {
            starButton.setTitleColor(.yellow, for: .normal)
            //starButton.tintColor = .yellow
            try! realm.write {
                word?.isFavorite = true
            }
        }
        
    }
    @IBAction func exit(_ sender: Any) {
        try! realm.write{
            word?.defenition = definition.text
        }
        self.dismiss(animated: true, completion: nil)
    }
}
