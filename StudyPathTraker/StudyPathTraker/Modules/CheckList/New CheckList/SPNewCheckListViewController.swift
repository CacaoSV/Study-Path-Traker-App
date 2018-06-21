//
//  SPNewCheckListViewController.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/14/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPNewCheckListViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var nameMilestoneTextField: UITextField!
    @IBOutlet weak var addNewButton: SPRoundedButton!

    // MARK: - Properties

    var milestone: Milestone?
    var item: Item?
    var isToEdit = false
    var newCheckListPresenter: SPNewCheckListPresenter = SPNewCheckListPresenter()

    // MARK: - View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Milestone"
        newCheckListPresenter.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if isToEdit {
            configureViewForEdit()
        }
    }

    func configureViewForEdit() {
        title = "Edit Milestone"
        nameMilestoneTextField.text = milestone?.name
        addNewButton.setTitle("EDIT", for: .normal)
    }

    @IBAction private func tappedAddButton(_ sender: Any) {
        handleActionForMilestone(name: nameMilestoneTextField.text ?? "")
    }

    func handleActionForMilestone(name: String) {
        if !name.isEmpty {
            if isToEdit {
                editMilestone(name: name)
            } else {
                createMilestone(name: name)
            }
        } else {
            showMessage("Name is a required field", title: "😅")
        }
    }
    
    private func createMilestone(name: String) {
        guard let currentItem = item else {
            return
        }
        newCheckListPresenter.addMilestone(Milestone.newMilestone(name: name), item: currentItem)
    }

    private func editMilestone(name: String) {
        guard let currentMilestone = milestone else {
            return
        }
        newCheckListPresenter.updateMilestone(currentMilestone, name: name)
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
