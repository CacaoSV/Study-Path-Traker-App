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

    @IBAction private func addNewCategory(_ sender: Any) {
        let name: String = nameCategoryTextField.text ?? ""
        if !name.isEmpty {
            self.navigationController?.popViewController(animated: true)
            if isToEdit, let currentCategory = category {
                presenter.updateCategoryName(name: name,
                                             category: currentCategory)
            } else {

                presenter.addCategory(createCategory(name: name))
            }
        } else {
            showMessage("You need to write a name to add the category", title: SPAlertStrings.errorText)
        }
    }

    func createCategory(name: String) -> CategoryItem {
       return CategoryItem(name: name,
                           progress: 0.0,
                           uid: NSUUID().uuidString,
                           items: [Item]()
        )
    }

}
extension SPNewCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addNewCategory(self)
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
