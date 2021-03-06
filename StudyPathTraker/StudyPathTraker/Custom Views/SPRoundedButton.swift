//
//  SPRoundedButton.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/09/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPRoundedButton: UIButton {

    @IBInspectable var backgroundColorButton: UIColor = UIColor.mainPurple {
        didSet {
            backgroundColor = backgroundColorButton
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        tintColor = UIColor.white
    }
}
