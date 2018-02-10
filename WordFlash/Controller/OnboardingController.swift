//
//  OnboardingController.swift
//  WordFlash
//
//  Created by Artemii Shabanov on 10.02.2018.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import UIKit
import paper_onboarding


class OnboardingController: UIViewController {
    
    @IBOutlet weak var onboarding: PaperOnboarding!
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func hideOnboarding() {
        getStartedButton.isEnabled = false
        getStartedButton.isHidden = true
        defaults.set(true, forKey: "ShowedOnboarding")
    }
    
}



// MARK: paper onboarding date sourse
extension OnboardingController: PaperOnboardingDataSource {
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
extension OnboardingController: PaperOnboardingDelegate {
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 3 {
            getStartedButton.isEnabled = true
            UIView.animate(withDuration: 0.4, animations: {
                self.getStartedButton.alpha = 1
            })
        } else {
            getStartedButton.isEnabled = false
            UIView.animate(withDuration: 0.2, animations: {
                self.getStartedButton.alpha = 0
            })
        }
    }
}
