//
//  SPNewItemPresenter.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/19/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

protocol SPNewItemPresenterProtocol: SPBasePresenterProtocol {
    var presenter: SPNewItemPresenter { get }
}

class SPNewItemPresenter {

    weak var delegate: SPNewItemPresenterProtocol?

    func addNewItem(_ item: Item, category: CategoryItem) {
        let result = PersistenceManager.updateItem {
            category.items.append(item)
        }
        switch result {
        case .success(_):
            delegate?.didSuccessAction("Item succsessfully added")
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }

    func updateItem(_ item: Item, name: String, url: String) {
        let result = PersistenceManager.updateItem {
            item.name = name
            item.url = url
        }
        switch result {
        case .success(_):
            delegate?.didSuccessAction("Item updated")
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }
}
