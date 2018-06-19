//
//  SPCheckListTableViewCell.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/4/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPCheckListTableViewCell: UITableViewCell {
    @IBOutlet weak var isReadySwitch: UISwitch!
    @IBOutlet private weak var nameMilestoneLabel: UILabel!
    
    func binding(milestone: Milestone) {
        nameMilestoneLabel.text = milestone.name
        isReadySwitch.isOn = milestone.isDone
    }
}
