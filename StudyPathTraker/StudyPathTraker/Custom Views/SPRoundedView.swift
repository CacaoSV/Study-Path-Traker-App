//
//  SPRoundedView.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 5/31/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPRoundedView: UIView {
    private let cornerSize: CGFloat = 8.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customizeView()
    }

    func customizeView() {
        layer.cornerRadius = cornerSize
        clipsToBounds = true
    }
}
