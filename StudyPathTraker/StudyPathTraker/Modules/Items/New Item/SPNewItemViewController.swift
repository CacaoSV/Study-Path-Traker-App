//
//  SPNewItemViewController.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/14/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

protocol SPItemDelegate: class {
    func didAddNewItem(name: String, url: String)
    func didEditItem(name: String, url: String, item: Item?)
}

class SPNewItemViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var urlTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var addButton: SPRoundedButton!
    
    // MARK: - Properties

    var item: Item?
    weak var delegate: SPItemDelegate?
    var isToEdit = false

    // MARK: - View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Item"
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
                delegate?.didAddNewItem(name: name, url: url)
            }
        }
    }

    private func editItem(name: String, url: String) {
        if verifyForm(name: name, url: url) {
            delegate?.didEditItem(name: name, url: url, item: item)
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
