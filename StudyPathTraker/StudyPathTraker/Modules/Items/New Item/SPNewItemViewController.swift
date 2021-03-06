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

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addButton: SPRoundedButton!

    // MARK: - Properties

    var item: Item?
    var category: CategoryItem?
    var isToEdit = false
    var newItemPresenter: SPNewItemPresenter = SPNewItemPresenter()

    // MARK: - View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Item"
        newItemPresenter.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if isToEdit {
            configureViewForEdit()
        }
    }

    // MARK: - Functions

    func configureViewForEdit() {
        title = "Edit Item"
        nameTextField.text = item?.name
        urlTextField.text = item?.url
        addButton.setTitle("EDIT", for: .normal)
    }

    @IBAction private func tappedAddButton(_ sender: Any) {
        let name = nameTextField.text ?? ""
        let url = urlTextField.text ?? ""

        if verifyForm(name: name, url: url) {
            if isToEdit {
                editItem(name: name, url: url)
            } else {
                createItem(name: name, url: url)
            }
        }
    }
    func createItem(name: String, url: String) {
        guard let currentCategory = category else {
            return
        }
        newItemPresenter.addNewItem(Item.newItem(name: name,
                                                 url: url),
                             category: currentCategory)
    }

    func editItem(name: String, url: String) {
        guard let currentItem = item else {
            return
        }
        newItemPresenter.updateItem(currentItem, name: name, url: url)
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
