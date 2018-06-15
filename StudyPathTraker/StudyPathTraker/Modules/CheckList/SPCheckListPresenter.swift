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
    func requestMilestones()
}

class SPCheckListPresenter {
    
    weak var delegate: SPCheckListPresenterProtocol?

    func addMilestone(_ milestone: Milestone, item: Item) {
        let result = PersistenceManager.updateItem {
            let currentMilestones = item.milestones
            currentMilestones.append(milestone)
            item.milestones = currentMilestones
        }
        switch result {
        case .success(_):
            delegate?.didSuccessAction("Milestone succsessfully added")
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }

    func deleteMilestone(_ milestone: Milestone) {
        let result = PersistenceManager.deleteItem(item: milestone)
        switch result {
        case .success(_):
            delegate?.didSuccessAction("Milestone deleted")
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }

    func updateMilestone(_ milestone: Milestone, name: String, isDone: Bool = false, item: Item) {
        let result = PersistenceManager.updateItem {
            milestone.name = name 
            milestone.isDone = isDone
        }
        // WIP Update intenally the progress of the item
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
