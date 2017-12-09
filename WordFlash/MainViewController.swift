import UIKit
import RealmSwift
import Koloda
import paper_onboarding
import SwiftyJSON
import Alamofire


//global
var realm: Realm = try! Realm()


class MainViewController: UIViewController{
    
    var words:Results<Word>!
    var shuffledWords:[Word] = []
    var state:State?
    var weAreGoingToAdd: Bool = true
    @IBOutlet weak var kolodaView: KolodaView!
    
    
    @IBOutlet var designView: UIView!
    
    //yep
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        designView.backgroundColor = UIColor(red: 0.0353, green: 0.0784, blue: 0.1176, alpha: 1.0)
        kolodaView.backgroundColor = UIColor(red: 0.0353, green: 0.0784, blue: 0.1176, alpha: 1.0)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //loading words from db
        words = realm.objects(Word.self).filter(NSPredicate(format: "inHistory == false"))
        shuffledWords = words.shuffled()
        print(shuffledWords.count)
        kolodaView.resetCurrentCardIndex()
        kolodaView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //custom buttons
    
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
            //history or favorite
            destination.state = state
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

// MARK: KolodaViewDelegate
extension MainViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
}

// MARK: KolodaViewDataSource
extension MainViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return shuffledWords.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let card = CardView()
        card.wordLabel.text = shuffledWords[index].word
        return card
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection){
        if direction == .left{
            try? realm.write {
                shuffledWords[index].remember()
            }
        } else if direction == .right {
            try? realm.write {
                shuffledWords[index].dontRemember()
            }
        }
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    /* like or nope
     func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
     return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)![0] as? OverlayView
     }*/
}


extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            self.swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
