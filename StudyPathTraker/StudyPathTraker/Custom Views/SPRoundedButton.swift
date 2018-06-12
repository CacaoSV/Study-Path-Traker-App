//
//  SPRoundedButton.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/09/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPRoundedButton: UIButton {
    
    let cornerSize: CGFloat = 8.0

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = cornerSize
        clipsToBounds = true
    }

}
