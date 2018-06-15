//
//  SPItemPresenter.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/14/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import Foundation

protocol SPItemPresenterProtocol: SPBasePresenterProtocol {
    var presenter: SPItemPresenter { get }

    func show(items: [Item])
    func requestItems()
}

class SPItemPresenter {

    weak var delegate: SPItemPresenterProtocol?

    func addNewItem(item: Item, category: CategoryItem) {
        let result = PersistenceManager.updateItem {
            let currentItems = category.items
            currentItems.append(item)
            category.items = currentItems
        }
        switch result {
        case .success(_):
            delegate?.didSuccessAction("Item succsessfully added")
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }

    func deleteItem(item: Item) {
        let result = PersistenceManager.deleteItem(item: item)
        switch result {
        case .success(_):
            delegate?.didSuccessAction("Item deleted")
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }

    func updateItem(item: Item, name: String, url: String) {
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

    func getItems(categoryUID: String) {
        let result = PersistenceManager.getItem(primaryKey: categoryUID, type: CategoryItem.self)
        switch result {
        case .success(let category):
            delegate?.show(items: Array(category.items))
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }
}
