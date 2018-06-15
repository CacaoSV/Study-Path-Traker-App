//
//  SPNewCheckListViewController.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/14/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

protocol SPCheckListDelegate: class {
    func didAddNewMilestone(name: String)
    func didEditMilestone(name: String, milestone: Milestone)
}

class SPNewCheckListViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var nameMilestone: UITextField!
    @IBOutlet private weak var addNewButton: SPRoundedButton!

    // MARK: - Properties

    var milestone: Milestone?
    weak var delegate: SPCheckListDelegate?
    var isToEdit = false

    // MARK: - View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Milestone"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if isToEdit {
            configureViewForEdit()
        }
    }

    private func configureViewForEdit() {
        title = "Edit Milestone"
        nameMilestone.text = milestone?.name
        addNewButton.setTitle("Edit", for: .normal)
    }

    @IBAction private func addNewMilestione(_ sender: Any) {
        let name = nameMilestone.text ?? ""
        if verifyForm(name: name) {
            if isToEdit {
                editMilestone(name: name)
            } else {
                delegate?.didAddNewMilestone(name: name)
            }
        }
    }
    private func editMilestone(name: String) {
        guard let currentMilestone = milestone else {
            return
        }
        delegate?.didEditMilestone(name: name, milestone: currentMilestone)
    }
    private func verifyForm(name: String) -> Bool {
        if !name.isEmpty {
            return true
        } else {
            showMessage("Name is a required field", title: "😅")
        }
        return false
    }
}
