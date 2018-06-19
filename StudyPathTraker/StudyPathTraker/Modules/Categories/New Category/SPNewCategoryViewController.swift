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
    @IBOutlet private weak var deleteButton: SPRoundedButton!

    // MARK: - Properties

    var newCategoryPresenter: SPNewCategoryPresenter = SPNewCategoryPresenter()
    var isToEdit: Bool = false
    var category: CategoryItem?

    // MARK: - View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Category"
        nameCategoryTextField.becomeFirstResponder()
        newCategoryPresenter.delegate = self
        if isToEdit {
            configureViewToEdit()
        }
    }

    func configureViewToEdit() {
        title = "Edit Category"
        nameCategoryTextField.text = category?.name
        addButton.setTitle("EDIT", for: .normal)
        deleteButton.isHidden = false
    }
    
    // MARK: - Functions

    @IBAction private func tappedAddButton(_ sender: Any) {
       handleActionForCategory(categoryName: nameCategoryTextField.text ?? "")
    }

    private func handleActionForCategory(categoryName: String) {
        if !categoryName.isEmpty {
            if isToEdit, let currentCategory = category {
                newCategoryPresenter.updateCategoryName(name: categoryName, category: currentCategory)
            } else {
                newCategoryPresenter.addCategory(CategoryItem.newCategory(name: categoryName))
            }
        } else {
            showMessage("You need to write a name to add the category", title: SPAlertStrings.errorText)
        }
    }

    @IBAction private func tappedDeleteButton(_ sender: Any) {
        performDeleteCategory()
    }

    private func performDeleteCategory() {
        guard let currentCategory = category else {
            return
        }
        newCategoryPresenter.deleteCategory(currentCategory)
    }
}
extension SPNewCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleActionForCategory(categoryName: textField.text ?? "")
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
