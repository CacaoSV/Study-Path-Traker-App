//
//  SPCategoryCollectionViewCell.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 4/30/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var totalProgressView: UIProgressView!
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }
    func binding(category: CategoryItem) {
        nameLabel.text = category.name
        totalProgressView.progress = category.progress
    }
}
