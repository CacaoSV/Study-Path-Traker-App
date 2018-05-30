//
//  SPLightNavigationControllerDelegate.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 5/30/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import Foundation
import UIKit

protocol backItem {
    func addbackItemButton(title: String)
}

extension backItem where Self: UIViewController {
    
    func addbackItemButton(title: String){
        let barButton = UIBarButtonItem()
        barButton.title = title
        self.navigationItem.backBarButtonItem = barButton
    }
    
}

extension UIViewController: backItem {}
