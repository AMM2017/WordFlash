//
//  CardView.swift
//  WordFlash
//
//  Created by xcode on 06.12.2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import UIKit

protocol StarPressedDelegate {
    func starPressed(for word:String)
}

class CardView: UIView {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var definitionLabel: UILabel!
    
    var delegate:StarPressedDelegate?
    
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
        definitionLabel.isHidden = true
        definitionLabel.textColor = .white
        let doubletap = UITapGestureRecognizer(target: self, action:  #selector (self.tapped (_:)))
        doubletap.numberOfTapsRequired = 2
        self.contentView.addGestureRecognizer(doubletap)
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: definitionLabel.bottomAnchor).isActive = true
    }
    
    @objc func tapped(_ sender:UITapGestureRecognizer) {
        flip()
    }
    
    public func construct(for word:Word) {
        wordLabel.text = word.word
        starButton.setImage( word.isFavorite ? #imageLiteral(resourceName: "smallorstar") : #imageLiteral(resourceName: "smallstar"), for: .normal)
        definitionLabel.text = word.definition
    }
    
    @IBAction func starPressed(_ sender: Any ) {
        starButton.setImage(starButton.currentImage == #imageLiteral(resourceName: "smallorstar") ? #imageLiteral(resourceName: "smallstar") : #imageLiteral(resourceName: "smallorstar"), for: .normal)
        delegate?.starPressed(for: wordLabel.text!)
    }
    
    @objc func flip() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: self, duration: 0.5, options: transitionOptions, animations: {
            self.definitionLabel.isHidden = !self.definitionLabel.isHidden
        })
    }
}

