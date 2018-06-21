//
//  SPCategoryPresenter.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/11/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

protocol SPCategoryPresenterProtocol: SPBasePresenterProtocol {
    var categoryPresenter: SPCategoryPresenter { get }

    func show(categories: [CategoryItem])
}

class SPCategoryPresenter {

    weak var delegate: SPCategoryPresenterProtocol?

    func getCategories() {
        let result = PersistenceManager.getAllItems(type: CategoryItem.self, filter: nil)
        switch result {
        case .success(let categories):
            delegate?.show(categories: categories)
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }
    
}
