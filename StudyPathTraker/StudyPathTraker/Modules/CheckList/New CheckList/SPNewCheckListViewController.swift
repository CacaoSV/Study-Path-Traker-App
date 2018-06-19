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
    var item: Item?
    var isToEdit = false
    var presenter: SPNewCheckListPresenter = SPNewCheckListPresenter()

    // MARK: - View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Milestone"
        presenter.delegate = self
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
        guard let currentItem = item else {
            return
        }
        if verifyForm(name: name) {
            if isToEdit {
                editMilestone(name: name)
            } else {
                presenter.addMilestone(createNewMilestone(name: name), item: currentItem)
            }
        }
    }
    private func editMilestone(name: String) {
        guard let currentMilestone = milestone else {
            return
        }
        presenter.updateMilestone(currentMilestone, name: name)
    }

    private func createNewMilestone(name: String) -> Milestone {
        return Milestone(uid: NSUUID().uuidString, isDone: false, name: name)
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
extension SPNewCheckListViewController: SPNewCheckListPresenterProtocol {

    func didSuccessAction(_ message: String) {
        navigationController?.popViewController(animated: true)
    }

    func showError(_ message: String) {
        showError(message)
    }
}
