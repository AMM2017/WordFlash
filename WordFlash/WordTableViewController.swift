import Foundation
import UIKit
import RealmSwift

enum State {
    case History
    case Favorite
}

class WordsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var words: Results<Word>!
    var state: State?
    var word: Word?
    var weAreGoingToAdd: Bool = true
    
    @IBOutlet weak var bar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoButton: UIButton!
    @IBOutlet weak var histButton: UIButton!
    @IBOutlet var designView: UIView!
    //img@3x
    
    
    //yep
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        designView.backgroundColor = UIColor(red: 0.0353, green: 0.0784, blue: 0.1176, alpha: 1.0)
        tableView.sectionIndexBackgroundColor = UIColor(red: 0.0353, green: 0.0784, blue: 0.1176, alpha: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if state == .History {
            histButton.setImage(#imageLiteral(resourceName: "histline"), for: .normal)
            favoButton.setImage(#imageLiteral(resourceName: "defstar"), for: .normal)
            histButton.isEnabled = false
            favoButton.isEnabled = true
        } else {
            favoButton.setImage(#imageLiteral(resourceName: "favstar"), for: .normal)
            histButton.setImage(#imageLiteral(resourceName: "defline"), for: .normal)
            favoButton.isEnabled = false
            histButton.isEnabled = true
        }
        //loading words from db
        words = realm.objects(Word.self).filter(NSPredicate(format: state == .History ? "inHistory == true" : "isFavorite == true"))
        tableView.reloadData()
        self.title = state == .History ? "History" : "Favorite"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    //tableView section
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordTableCell.reuseId) as? WordTableCell
            else {
                fatalError("Fatal error")
        }
        cell.set(word: words[indexPath.row].word)
        cell.set(color: state == .History ? .yellow : .green)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        word = words[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        weAreGoingToAdd = false
        self.performSegue(withIdentifier: state == .Favorite ? "FavoriteSegue" : "HistorySegue", sender: self)
    }
    
    
    
    //custom buttons
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addWord(_ sender: Any) {
        weAreGoingToAdd = true
        self.performSegue(withIdentifier: "AddWordSegue", sender: self)
    }
    @IBAction func showOtherList(_ sender: Any) {
        state = state == .History ? .Favorite : .History
        self.viewDidAppear(false)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !weAreGoingToAdd {
            if state == .History {
                guard let destination = segue.destination as? HistoryWordViewController
                    else {fatalError("Some Error")}
                
                destination.word = word
            }
            else {
                guard let destination = segue.destination as? FavoriteWordViewController
                    else {fatalError("Some Error")}
                
                destination.word = word
            }
        } else {
            guard let destination = segue.destination as? AddWordViewController
                else {fatalError("Some Error")}
            //getting all words from db and sending them to addview
            var alreadyHaveWords: [String] = []
            for word in realm.objects(Word.self) {
                alreadyHaveWords.append( word.word )
            }
            destination.alreadyHaveWords = alreadyHaveWords
        }
    }
    
}
