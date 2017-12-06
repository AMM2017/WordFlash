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
    @IBOutlet weak var kolodaView: KolodaView!
    
    /*fileprivate var dataSource: [UILabel] = {
     var array: [UILabel] = []
     for index in 0..<numberOfCards {
     }
     return array
     }()*/
    
    
    //yep
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //loading words from db
        words = realm.objects(Word.self).filter(NSPredicate(format: "isInHistory == false"))
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
        return 5//dataSource.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return (Bundle.main.loadNibNamed("CardView", owner: self, options: nil)![0] as? UIView)!
    }
    
    /* like or nope
     func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
     return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)![0] as? OverlayView
     }*/
}
