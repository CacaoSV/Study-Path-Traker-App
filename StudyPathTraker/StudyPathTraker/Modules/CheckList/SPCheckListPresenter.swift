//
//  SPCheckListPresenter.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/14/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import Foundation

protocol SPCheckListPresenterProtocol: SPBasePresenterProtocol {
    var presenter: SPCheckListPresenter { get }

    func show(milestones: [Milestone])
}

class SPCheckListPresenter {
    
    weak var delegate: SPCheckListPresenterProtocol?

    func deleteMilestone(_ milestone: Milestone) {
        let result = PersistenceManager.deleteItem(item: milestone)
        switch result {
        case .success(_):
            delegate?.didSuccessAction("Milestone deleted")
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }

    func updateMilestone(_ milestone: Milestone, name: String, isDone: Bool = false) {
        let result = PersistenceManager.updateItem {
            milestone.name = name 
            milestone.isDone = isDone
        }
        switch result {
        case .success(_):
            delegate?.didSuccessAction("Item updated")
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }

    func getMilestones(itemUID: String) {
        let result = PersistenceManager.getItem(primaryKey: itemUID, type: Item.self)
        switch result {
        case .success(let item):
            delegate?.show(milestones: Array(item.milestones))
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }
}
