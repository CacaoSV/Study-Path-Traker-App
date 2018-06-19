//
//  SPNewCategoryPresenter.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/19/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

protocol SPNewCategoryPresenterProtocol: SPBasePresenterProtocol {
    var presenter: SPNewCategoryPresenter { get }
    
}

class SPNewCategoryPresenter {

    weak var delegate: SPNewCategoryPresenterProtocol?

    func addCategory(_ category: CategoryItem) {
        let result = PersistenceManager.saveItem(item: category)
        switch result {
        case .success(_):
            delegate?.didSuccessAction("Category succsessfully added")
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
    
    func deleteCategory(_ category: CategoryItem) {
        let result = PersistenceManager.deleteItem(item: category)
        switch result {
        case .success(_):
            delegate?.didSuccessAction("Category deleted")
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }
}
