import UIKit

class WordTableCell: UITableViewCell{
    
    @IBOutlet weak var WordLabel: UILabel!
    public static let reuseId = "WordTableCell_reuseId"
    
    public func set(word:String) {
        WordLabel.text = word
    }
    
    public func set(color: UIColor) {
        self.backgroundColor = color
    }
    
    
    
}
