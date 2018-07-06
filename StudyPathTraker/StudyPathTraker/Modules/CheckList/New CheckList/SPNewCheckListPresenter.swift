//
//  SPNewCheckListPresenter.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/19/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

protocol SPNewCheckListPresenterProtocol: SPBasePresenterProtocol {
    var newCheckListPresenter: SPNewCheckListPresenter { get }
}

class SPNewCheckListPresenter {

    weak var delegate: SPNewCheckListPresenterProtocol?

    func addMilestone(_ milestone: Milestone, item: Item) {
        let result = PersistenceManager.updateItem {
            item.milestones.append(milestone)
        }
        switch result {
        case .success(_):
            delegate?.didSuccessAction("Milestone succsessfully added")
        case .failure(let error):
            delegate?.showError(error.localizedDescription)
        }
    }

    func updateMilestone(_ milestone: Milestone, name: String) {
        let isDone = milestone.isDone
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
}
