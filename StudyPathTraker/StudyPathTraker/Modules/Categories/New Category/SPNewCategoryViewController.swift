//
//  SPNewCategoryViewController.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/10/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

protocol SPCategoryDelegate: NSObjectProtocol {
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

    @IBAction private func addCategory(_ sender: Any) {
        let nameCategory: String = nameCategoryTextField.text ?? ""
        if !nameCategory.isEmpty {
            self.navigationController?.popViewController(animated: true)
            delegate?.didAddNewCategory(name: nameCategory)
        } else {
            self.present(SPAlertCenter.showMessageWithTitle(message: "You need to write a name to add the category"), animated: true, completion: nil)
        }
    }
}
extension SPNewCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addCategory(self)
        return true
    }
}
