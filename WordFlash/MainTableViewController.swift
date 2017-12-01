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
    static let path = "dictionary"

    //let dict = Dictionary.load(from: path)
    let words = Dictionary.getArrayofKeys(from:
        Dictionary.load(from: path)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        print()
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
        return words.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewController.reuse_id, for: indexPath)
        
        cell.textLabel?.text = words[indexPath.row]
        return cell
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }

}
