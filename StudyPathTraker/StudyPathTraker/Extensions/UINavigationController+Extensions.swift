//
//  UINavigationController+Extensions.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 5/30/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

extension UINavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self as? UINavigationControllerDelegate
        self.interactivePopGestureRecognizer?.delegate = self
        if let font = UIFont(name: "Avenir", size: 18) {
            self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.mainPurple,
                                                      NSAttributedStringKey.font: font]
        }
    }
}

extension UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {
        viewController.addbackItemButton(title: "")
    }

}

extension UINavigationController: UIGestureRecognizerDelegate {
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
