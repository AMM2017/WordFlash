import Foundation
import UIKit
import RealmSwift


class AddWordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let allWords: [String] = ["door", "pen", "pencil", "pool", "floor", "book", "great"]
    var filteredWords: [String] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredWords = allWords
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredWords.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordTableCell.reuseId) as? WordTableCell
            else {
                fatalError("Fatal error")
        }
        
        cell.configure(word: filteredWords[indexPath.row])
        cell.setColor(color: .gray)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let word = Word()
        word.word = filteredWords[indexPath.row]
        word.defenition = "get from dict"
        word.isInHistory = true
        try! realm.write{
            realm.add(word)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

