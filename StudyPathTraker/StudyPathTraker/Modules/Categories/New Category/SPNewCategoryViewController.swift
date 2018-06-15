//
//  SPNewCategoryViewController.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/10/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

protocol SPCategoryDelegate: class {
    func didAddNewCategory(name: String)
}

class SPNewCategoryViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var nameCategoryTextField: UITextField!

    // MARK: - Properties

    weak var delegate: SPCategoryDelegate?

    // MARK: - View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Category"
        nameCategoryTextField.becomeFirstResponder()
    }

    // MARK: - Functions

    @IBAction private func addNewCategory(_ sender: Any) {
        let name: String = nameCategoryTextField.text ?? ""
        createCategory(name: name)
    }

    func createCategory(name: String) {
        if !name.isEmpty {
            self.navigationController?.popViewController(animated: true)
            delegate?.didAddNewCategory(name: name)
        } else {
            showMessage("You need to write a name to add the category", title: SPAlertStrings.errorText)
        }
    }

}
extension SPNewCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addNewCategory(self)
        return true
    }
}
