//
//  SPCategoryPresenter.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/11/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

protocol SPCategoryPresenterProtocol: class {
    var presenter: SPCategoryPresenter { get }

    func didAddNewCategorySuccess(_ message: String)
    func show(categories: [CategoryItem])
    func requestCategories()
}

class SPCategoryPresenter: NSObject {

    weak var delegate: SPCategoryPresenterProtocol?

    func addNewCategory(categoryName: String) {
        let category: CategoryItem = CategoryItem(name: categoryName, progress: 0)
        let result = PersistenceManager.saveItem(item: category)
        switch result {
        case .success(_):
            delegate?.didAddNewCategorySuccess("Category succsessfully added")
        case .failure(let error):
            print(error)
        }
    }

    func getCategories() {
        let result = PersistenceManager.getAllItems(type: CategoryItem.self, filter: nil)
        switch result {
        case .success(let categories):
            delegate?.show(categories: categories)
        case .failure(let error):
            print(error)
        }
    }
}
