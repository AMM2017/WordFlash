import UIKit
import Koloda
import paper_onboarding

enum SegueTargetMain {
    case History 
    case Favorite
    case Add
}

class MainViewController: UIViewController{
    
    var words:[Word] = []
    var shuffledWords:[Word] = []
    var segueTarget:SegueTargetMain?
    
    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet var designView: UIView!
    @IBOutlet weak var onboarding: PaperOnboarding!
    @IBOutlet weak var getStartedButton: UIButton!
    
    //MARK: ViewController stuff
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.dataSource = self
        kolodaView.delegate = self
        kolodaView.backgroundColor = Color.dolphin
        words = realm.objects(Word.self).filter(NSPredicate(format: "isAddedByUser == true and inHistory == false")).map{$0}
        shuffledWords = (words + Functions.getRandomWords(on: 5)).shuffled()
        kolodaView.resetCurrentCardIndex()
        kolodaView.reloadData()
        refreshButton.isHidden = true
        refreshButton.isEnabled = false
        
        //onboarding
        if defaults.object(forKey: "ShowedOnboarding") == nil {
            onboarding.dataSource = self
            onboarding.delegate = self
            onboarding.translatesAutoresizingMaskIntoConstraints = false
            onboarding.isHidden = false
            
            // add constraints
            for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
                let constraint = NSLayoutConstraint(item: onboarding,
                                                    attribute: attribute,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: attribute,
                                                    multiplier: 1,
                                                    constant: 0)
                view.addConstraint(constraint)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //loading words from db
        words = realm.objects(Word.self).filter(NSPredicate(format: "isAddedByUser == true and inHistory == false")).map{$0}
    }
    
    
    //MARK: custom buttons
    
    @IBAction func addWord(_ sender: Any) {
        segueTarget = .Add
        self.performSegue(withIdentifier: "AddWordSegue", sender: self)
    }
    
    @IBAction func showFavorite(_ sender: Any) {
        segueTarget = .Favorite
        self.performSegue(withIdentifier: "TableSegue", sender: self)
    }
    
    @IBAction func showHistory(_ sender: Any) {
        segueTarget = .History
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
    
    
    @IBAction func hideOnboarding() {
        onboarding.isHidden = true
        getStartedButton.isEnabled = false
        getStartedButton.isHidden = true
      //  defaults.set(true, forKey: "ShowedOnboarding")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueTarget! {
        case .Add:
            break;
        case .History:
            guard let destination = segue.destination as? WordsTableViewController
                else {fatalError("Some Error")}
            destination.state = .History
        case .Favorite:
            guard let destination = segue.destination as? WordsTableViewController
                else {fatalError("Some Error")}
            destination.state = .Favorite
        }
    }
    
    
    // MARK: for kolodaView
    private func update(_ koloda: KolodaView) {
        words = realm.objects(Word.self).filter(NSPredicate(format: "isAddedByUser == true and inHistory == false")).map{$0}
        shuffledWords = (words + Functions.getRandomWords(on: 5)).shuffled()
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


// MARK: paper onboarding date sourse
extension MainViewController: PaperOnboardingDataSource {
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        return [
            OnboardingItemInfo(imageName: #imageLiteral(resourceName: "login"),
                               title: "DOUBLE TAP",
                               description: "to see definition",
                               iconName: #imageLiteral(resourceName: "login"),
                               color: Color.dolphin,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.italicSystemFont(ofSize: 25),
                               descriptionFont: UIFont.italicSystemFont(ofSize: 18)),
            
            OnboardingItemInfo(imageName: #imageLiteral(resourceName: "login"),
                               title: "SWIPE LEFT",
                               description: "if you know definition",
                               iconName: #imageLiteral(resourceName: "login"),
                               color: Color.dolphin,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.italicSystemFont(ofSize: 25),
                               descriptionFont: UIFont.italicSystemFont(ofSize: 18)),
            
            OnboardingItemInfo(imageName: #imageLiteral(resourceName: "login"),
                               title: "SWIPE RIGHT",
                               description: "if you don't",
                               iconName: #imageLiteral(resourceName: "login"),
                               color: Color.dolphin,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.italicSystemFont(ofSize: 25),
                               descriptionFont: UIFont.italicSystemFont(ofSize: 18)),
            
            OnboardingItemInfo(imageName: #imageLiteral(resourceName: "login"),
                               title: "PRESS STAR",
                               description: "to add to \"favorite\"",
                               iconName: #imageLiteral(resourceName: "login"),
                               color: Color.dolphin,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.italicSystemFont(ofSize: 25),
                               descriptionFont: UIFont.italicSystemFont(ofSize: 18))
            ][index]
    }
    
    func onboardingItemsCount() -> Int {
        return 4
    }
    
}


// MARK: paper onboarding delegate
extension MainViewController: PaperOnboardingDelegate {
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 3 {
            getStartedButton.isEnabled = true
            UIView.animate(withDuration: 0.4, animations: {
                self.getStartedButton.alpha = 1
            })
        } else {
            getStartedButton.isEnabled = false
            UIView.animate(withDuration: 0.4, animations: {
                self.getStartedButton.alpha = 0
            })
        }
    }
    
    
}


