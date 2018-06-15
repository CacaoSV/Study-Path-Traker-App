//
//  SPRoundedButton.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/09/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPRoundedButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customizeButton()
    }
    
    private func customizeButton() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        backgroundColor = UIColor.mainPurple
        tintColor = UIColor.white
    }

}
