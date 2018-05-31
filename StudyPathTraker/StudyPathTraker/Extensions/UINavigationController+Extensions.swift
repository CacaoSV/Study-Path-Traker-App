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
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.mainPurple, NSAttributedStringKey.font: UIFont(name: "Avenir", size: 18)!]
    }
}

extension UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.addbackItemButton(title: "")
    }
    
}

extension UINavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool  {
        if let _ = self.navigationController {
            if self.topViewController == self.viewControllers.first {
                return false
            }
            return true
        }
        return false
    }
}

