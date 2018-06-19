//
//  SPNewItemViewController.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/14/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPNewItemViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var urlTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var addButton: SPRoundedButton!
    
    // MARK: - Properties

    var item: Item?
    var category: CategoryItem?
    var isToEdit = false
    var presenter: SPNewItemPresenter = SPNewItemPresenter()

    // MARK: - View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Item"
        presenter.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if isToEdit {
            configureViewForEdit()
        }
    }

    // MARK: - Functions

    private func configureViewForEdit() {
        title = "Edit Item"
        nameTextField.text = item?.name
        urlTextField.text = item?.url
        addButton.setTitle("Edit", for: .normal)
    }

    @IBAction private func addNewItem(_ sender: Any) {
        let name = nameTextField.text ?? ""
        let url = urlTextField.text ?? ""

        if verifyForm(name: name, url: url) {
            if isToEdit {
                editItem(name: name, url: url)
            } else {
                guard let currentCategory = category else {
                    return
                }
                presenter.addNewItem(createNewItem(name: name,
                                                   url: url),
                                     category: currentCategory)
            }
        }
    }

    private func createNewItem(name: String, url: String) -> Item {
        return Item(uid: NSUUID().uuidString,
                    name: name, progress: 0.0,
                    url: url,
                    milestones: [Milestone]()
        )
    }

    private func editItem(name: String, url: String) {
        if let currentItem = item {
            presenter.updateItem(currentItem, name: name, url: url)
        }
    }

    private func verifyForm(name: String, url: String) -> Bool {
        if !name.isEmpty {
            if verifyURL(urlString: url) {
                return true
            } else {
                showMessage("Invalid url", title: "😅")
            }
        } else {
            showMessage("Name is a required field", title: "😅")
        }
        return false
    }

    private func verifyURL(urlString: String) -> Bool {
        if let url = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
}
extension SPNewItemViewController: SPNewItemPresenterProtocol {

    func didSuccessAction(_ message: String) {
        navigationController?.popViewController(animated: true)
    }

    func showError(_ message: String) {
        showError(message)
    }
}
