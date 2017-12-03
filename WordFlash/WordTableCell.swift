
import UIKit

class WordTableCell: UITableViewCell{
    
    @IBOutlet weak var WordLabel: UILabel!
    public static let reuseId = "WordTableCell_reuseId"
    
    public func setLabel(word:String) {
        WordLabel.text = word
    }
    
    public func setColor(color: UIColor) {
        self.backgroundColor = color
    }
    
}
