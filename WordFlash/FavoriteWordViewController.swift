import UIKit

class FavoriteWordViewController: UIViewController {
    
    var word:Word?
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var definition: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //yep
    override func viewDidLoad() {
        super.viewDidLoad()
        wordLabel.text = word?.word
        definition.text = word?.definition
        contentView.layer.borderColor = (UIColor(red:239.0,green:174.0,blue:0.0,alpha:1.0)).cgColor
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: definition.bottomAnchor).isActive = true
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    //custom buttons
    @IBAction func starPressed(_ sender: Any) {
        //changing isFavorite state
        if word!.isFavorite {
            starButton.setImage(#imageLiteral(resourceName: "smallstar"), for: .normal)
            try! realm.write {
                word?.isFavorite = false
            }
        }
        else {
            starButton.setImage(#imageLiteral(resourceName: "smallorstar"), for: .normal)
            try! realm.write {
                word?.isFavorite = true
            }
        }
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
