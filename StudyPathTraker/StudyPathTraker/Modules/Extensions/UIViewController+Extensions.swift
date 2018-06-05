//
//  UIViewController+Extensions.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 5/31/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

extension UIViewController {
    func addbackItemButton(title: String) {
        let barButton = UIBarButtonItem()
        barButton.title = title
        self.navigationItem.backBarButtonItem = barButton
    }
}
