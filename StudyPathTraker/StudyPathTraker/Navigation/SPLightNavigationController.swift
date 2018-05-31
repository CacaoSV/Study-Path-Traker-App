//
//  SPLightNavigationController.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 5/30/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPLightNavigationController: UINavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self 
        self.interactivePopGestureRecognizer?.delegate = self
        self.navigationBar.barTintColor = .white
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = .mainPurple
        if let font = UIFont(name: "Avenir", size: 18) {
            self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.mainPurple,
                                                      NSAttributedStringKey.font: font]
        }
    }
}

extension SPLightNavigationController: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {
        viewController.addbackItemButton(title: "")
    }

}

extension SPLightNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.navigationController != nil {
            if self.topViewController == self.viewControllers.first {
                return false
            }
            return true
        }
        return false
    }
}
