import UIKit
import RealmSwift
import Koloda
import paper_onboarding
import SwiftyJSON
import Alamofire


//global
var realm: Realm = try! Realm()
let defaults:UserDefaults = UserDefaults.standard

class MainViewController: UIViewController{
    
    var words:[Word] = []
    var shuffledWords:[Word] = []
    var state:State?
    var weAreGoingToAdd: Bool = true
    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet var designView: UIView!
    
    //MARK: ViewController stuff
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        kolodaView.backgroundColor = UIColor(red: 0.0353, green: 0.0784, blue: 0.1176, alpha: 1.0)
        words = realm.objects(Word.self).filter(NSPredicate(format: "isAddedByUser == true and inHistory == false")).map{$0}
        shuffledWords = (words + getRandomWords(on: 5)).shuffled()
        print(shuffledWords.count)
        kolodaView.resetCurrentCardIndex()
        kolodaView.reloadData()
        refreshButton.isHidden = true
        refreshButton.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //loading words from db
        words = realm.objects(Word.self).filter(NSPredicate(format: "isAddedByUser == true and inHistory == false")).map{$0}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: custom buttons stuff
    
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
    
    @IBAction func refresh(_ sender: Any) {
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.refreshButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
        UIView.animate(withDuration: 0.5, delay: 0.45, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.refreshButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
        }, completion: {(finished:Bool) in
            self.refreshButton.isHidden = true
            self.refreshButton.isEnabled = false
            self.update(self.kolodaView)
        })
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
    
    private func update(_ koloda: KolodaView) {
        words = realm.objects(Word.self).filter(NSPredicate(format: "isAddedByUser == true and inHistory == false")).map{$0}
        shuffledWords = (words + getRandomWords(on: 5)).shuffled()
        // koloda.applyAppearAnimationIfNeeded()
        koloda.resetCurrentCardIndex()
        koloda.reloadData()
    }
}

// MARK: KolodaViewDelegate
extension MainViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        refreshButton.isHidden = false
        refreshButton.isEnabled = true
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
        card.delegate = self
        card.construct(for: shuffledWords[index])
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
        return true
    }
    
    /* like or nope
     func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
     return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)![0] as? OverlayView
     }*/
}


// MARK: star pressed delegate
extension MainViewController: StarPressedDelegate {
    func starPressed(for word:String) {
        try! realm.write{
            if let model = realm.object(ofType: Word.self, forPrimaryKey: word){
                model.changeFavoriteState()
            }
            else {
                let model = Word()
                model.word = word
                model.definition = Dictionary.sharedInstance[word]
                model.isAddedByUser = false
                model.isFavorite = true
                realm.add(model)
            }
        }
    }
}


// MARK: dictionary random n
private func getRandomWords(on count: Int) -> [Word]
{
    let allWords = Dictionary.sharedInstance.words
    var res: Set<Word> = []
    while (res.count < count) {
        let word = Word()
        word.word = allWords[Int(arc4random_uniform(UInt32(allWords.count)))]
        word.definition = Dictionary.sharedInstance[word.word]
        word.isAddedByUser = false
        res.insert(word)
    }
    return Array(res)
}


