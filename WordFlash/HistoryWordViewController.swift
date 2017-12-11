import UIKit

class HistoryWordViewController: UIViewController {
    
    var word:Word?
    @IBOutlet weak var definition: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    
    
    //yep
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordLabel.text = word?.word
        definition.text = word?.definition

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    //custom button
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
