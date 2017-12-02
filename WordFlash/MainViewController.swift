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


//global
var realm:Realm = try! Realm()


class MainViewController: UIViewController{
    
    var words:Results<Word>!
    var state:State?
    var weAreGoingToAdd: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        words = realm.objects(Word.self).filter(NSPredicate(format: "isInHistory == false"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addWord(_ sender: Any) {
        weAreGoingToAdd = true
        self.performSegue(withIdentifier: "AddWordSegue", sender: self)
    }
    
    @IBAction func showFavorite(_ sender: Any) {
        weAreGoingToAdd = false
        state = .Favorite
        self.performSegue(withIdentifier: "TableSegue", sender: self)
    }
    @IBAction func showHistory(_ sender: Any) {
        weAreGoingToAdd = false
        state = .History
        self.performSegue(withIdentifier: "TableSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !weAreGoingToAdd {
            guard let destination = segue.destination as? WordsTableViewController
                else {fatalError("Some Error")}
            destination.state = state
        }
    }
    
}
