//
//  CardView.swift
//  WordFlash
//
//  Created by xcode on 06.12.2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import UIKit

class CardView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = UIColor(red: 0.0353, green: 0.0784, blue: 0.1176, alpha: 1.0)
        contentView.layer.borderColor = (UIColor(red:255.0,green:255.0,blue:255.0,alpha:1.0)).cgColor
        wordLabel.textColor = UIColor.white
    }
}
