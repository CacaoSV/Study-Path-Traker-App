//
//  SPAlertCenter.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/11/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPAlertCenter {
    
    static func showMessageWithTitle(_ title: String = "", message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let proceedAction = UIAlertAction(title: SPAlertCenterStrings.okString, style: .default, handler: nil)
        alert.addAction(proceedAction)
        alert.view.tintColor = UIColor.mainPurple
        return alert
    }
}
