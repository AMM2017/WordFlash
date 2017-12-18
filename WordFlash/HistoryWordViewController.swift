import UIKit

class HistoryWordViewController: UIViewController {
    
    var word:Word?
    @IBOutlet weak var definition: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var contentViewHist: UIView!
    
    //yep
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordLabel.text = word?.word
        definition.text = word?.definition
        contentViewHist.layer.borderColor = (UIColor(red:113.0,green:255.0,blue:170.0,alpha:1.0)).cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    //custom button
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
