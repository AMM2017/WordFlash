//
//  MainTableViewController.swift
//  WordFlash
//
//  Created by Alexandr on 01/12/2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainTableViewController: UITableViewController {
    static let reuse_id = "reuse_id"

    let dictionary = Dictionary.sharedInstance
    var currentWord = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dictionary.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewController.reuse_id, for: indexPath)
        
        cell.textLabel?.text = dictionary.word(at: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentWord = dictionary.word(at: indexPath.row)!
        print("Current word is setup: \(currentWord)")
        performSegue(withIdentifier: "ShowDefinition", sender: self)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let  destination = segue.destination as? ShowWordDescroptionViewController {
            print("prepare for segue!")
            destination.word = currentWord
            destination.descript = dictionary.decrtiption(at: currentWord)
            print("current word: \(currentWord) desc: \(destination.descript)")
        }
    }

}
