//
//  SPCategoryCollectionViewCell.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 4/30/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalProgressView: UIProgressView!
    let cornerSize = 10
    
    func binding(category: CategoryItem) {
        nameLabel.text = category.name
        totalProgressView.progress = category.progress
    }
    
    func customizeCell() {
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
