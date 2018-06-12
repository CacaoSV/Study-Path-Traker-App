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

    func showMessage(_ message: String, title: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let proceedAction = UIAlertAction(title: SPAlertStrings.okText, style: .default, handler: nil)
        alert.addAction(proceedAction)
        alert.view.tintColor = UIColor.mainPurple
        present(alert, animated: true, completion: nil)
    }
}
