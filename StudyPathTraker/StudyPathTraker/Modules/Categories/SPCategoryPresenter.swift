//
//  SPCategoryPresenter.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/11/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

protocol SPCategoryPresenterProtocol: SPBasePresenterProtocol {
    var presenter: SPCategoryPresenter { get }

    func show(categories: [CategoryItem])
    func requestCategories()
}

class SPCategoryPresenter {

    weak var delegate: SPCategoryPresenterProtocol?

    func addNewCategory(categoryName: String) {
        let items = [Item]()
        let category: CategoryItem = CategoryItem(name: categoryName, progress: 0.0, uid: NSUUID().uuidString, items: items)
        let result = PersistenceManager.saveItem(item: category)
        switch result {
        case .success(_):
            delegate?.didSuccessAction("Category succsessfully added")
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }

    func getCategories() {
        let result = PersistenceManager.getAllItems(type: CategoryItem.self, filter: nil)
        switch result {
        case .success(let categories):
            delegate?.show(categories: categories)
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }

    func deleteCategory(_ category: CategoryItem) {
        let result = PersistenceManager.deleteItem(item: category)
        switch result {
        case .success(_):
            delegate?.didSuccessAction("Category deleted")
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }

    func updateCategoryName(name: String, category: CategoryItem) {
        let result = PersistenceManager.updateItem {
            category.name = name
        }
        switch result {
        case .success(_):
            delegate?.didSuccessAction("Category updated")
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }
}
