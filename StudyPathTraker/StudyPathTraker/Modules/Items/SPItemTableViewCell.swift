//
//  SPItemTableViewCell.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 5/31/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPItemTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var totalProgressView: UIProgressView!

    func binding(item: Item) {
        nameLabel.text = item.name
        totalProgressView.progress = item.progress
    }
}
