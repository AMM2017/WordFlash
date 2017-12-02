import Foundation
import UIKit
import RealmSwift


class AddWordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let allWords: [String] = []
    var filteredWords: [String] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allWords.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordTableCell.reuseId) as? WordTableCell
            else {
                fatalError("Fatal error")
        }
        
        cell.configure(word: allWords[indexPath.row])
        cell.setColor(color: .gray)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        word = words[indexPath.row]
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

