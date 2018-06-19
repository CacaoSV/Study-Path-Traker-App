//
//  SPNewCategoryViewController.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/10/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPNewCategoryViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var addButton: SPRoundedButton!
    @IBOutlet private weak var nameCategoryTextField: UITextField!

    // MARK: - Properties

    var presenter: SPNewCategoryPresenter = SPNewCategoryPresenter()
    var isToEdit: Bool = false
    var category: CategoryItem?

    // MARK: - View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Category"
        nameCategoryTextField.becomeFirstResponder()
        presenter.delegate = self
        if isToEdit {
            configureViewToEdit()
        }
    }

    func configureViewToEdit() {
        title = "Edit Item"
        nameCategoryTextField.text = category?.name
        addButton.setTitle("Edit", for: .normal)
    }
    
    // MARK: - Functions

    @IBAction private func tappedAddButton(_ sender: Any) {
        let name: String = nameCategoryTextField.text ?? ""
        if verifyForm(name: name) {
            if isToEdit, let currentCategory = category {
                updateCategory(name: name, category: currentCategory)
            } else {
                createCategory(name: name)
            }
        }
    }

    private func handleActionForCategory(categoryName: String) {
        if isToEdit, let currentCategory = category {
            updateCategory(name: categoryName, category: currentCategory)
        } else {
            createCategory(name: categoryName)
        }
    }

    private func verifyForm(name: String) -> Bool {
        if !name.isEmpty {
            return true
        }
        showMessage("You need to write a name to add the category", title: SPAlertStrings.errorText)
        return false
    }

    private func createCategory(name: String) {
        presenter.addCategory(CategoryItem.newCategory(name: name))
    }

    private func updateCategory(name: String, category: CategoryItem) {
        presenter.updateCategoryName(name: name, category: category)
    }
}
extension SPNewCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let name: String = textField.text ?? ""
        if verifyForm(name: name) {
            handleActionForCategory(categoryName: name)
        }
        return true
    }
}

extension SPNewCategoryViewController: SPNewCategoryPresenterProtocol {

    func didSuccessAction(_ message: String) {
        navigationController?.popViewController(animated: true)
    }

    func showError(_ message: String) {
        showError(message)
    }
}
