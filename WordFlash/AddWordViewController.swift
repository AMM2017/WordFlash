import Foundation
import UIKit
import RealmSwift


class AddWordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    static let dict: Dictionary = Dictionary.sharedInstance
    //let allWords: [String] = ["Door", "Pen", "Pencil", "Pool", "Floor", "Book", "Great", "Pottt", "Fgdgd", "Gfgdgs", "Ggsrgrwegwgr", "Qwert"]
    let allWords: [String] = dict.words
    var alreadyHaveWords: [String]?
    var filteredWords: [String] = []
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //yep
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //todo loading
        filteredWords = allWords
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    //tableView section
    
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
        cell.set(word: filteredWords[indexPath.row])
        cell.set(color: alreadyHaveWords!.contains(cell.WordLabel.text!) ? .yellow : .gray)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //adding word to realm
        let word = Word()
        word.word = filteredWords[indexPath.row]
        word.defenition = AddWordViewController.dict[word.word]
        if !alreadyHaveWords!.contains(word.word) {
            try? realm.write {
                realm.add(word)
            }
            self.dismiss(animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //searchBar section
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //filtering words
        filteredWords = allWords.filter { $0.capitalized.starts(with: searchText.capitalized) }
        tableView.reloadData()
    }
    
    
    
    //custom button
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

