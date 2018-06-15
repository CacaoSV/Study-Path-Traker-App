//
//  SPCheckListViewController.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/4/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit
import RealmSwift

class SPCheckListViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var checkListTableViewDelegate: SPCommonTableViewDelegate! {
        didSet {
            checkListTableViewDelegate.selectedIndex = { [weak self] index in
                guard let currentMilestones = self?.milestones else {
                    return
                }
                self?.selectedMilestone = currentMilestones[index]
                self?.performSegue(withIdentifier: Segues.MilestoneSegues.showAddMilestone.rawValue, sender: nil)
            }
        }
    }

    // MARK: - Properties

    var item: Item?
    var selectedMilestone: Milestone?
    private var dataSource: SPCommonTableViewDataSource<Milestone, SPCheckListTableViewCell>?
    private var refreshControl = UIRefreshControl()
    private var milestones: [Milestone]? {
        didSet {
            setMilestones()
        }
    }
    private let cellConfiguration = SPCommonCellConfiguration(identifier: "CheckListCellIdentifier", height: 70.0)
    var presenter: SPCheckListPresenter = SPCheckListPresenter()

    // MARK: - View Configuration

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Milestones"
        configureTableView()
        presenter.delegate = self
        requestMilestones()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newMilestoneViewController = segue.destination  as? SPNewCheckListViewController {
            newMilestoneViewController.delegate = self
            if let milestoneToUpdate = selectedMilestone {
                newMilestoneViewController.milestone = milestoneToUpdate
                newMilestoneViewController.isToEdit = true
            }
        }
    }
    // MARK: - Functions

    private  func configureTableView() {
        tableView.backgroundColor = .mainBackground
        tableView.rowHeight = cellConfiguration.height
        refreshControl.attributedTitle = NSAttributedString(string: "Loading milestones")
        refreshControl.addTarget(self, action: #selector(getMilestones), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc private func getMilestones() {
        requestMilestones()
        setMilestones()
    }

    private func setMilestones() {
        guard let currentMilestones = milestones else {
            refreshControl.endRefreshing()
            return
        }
        dataSource = SPCommonTableViewDataSource<Milestone, SPCheckListTableViewCell>(data: currentMilestones, reuseIdentifier: cellConfiguration.identifier, deleteAllowed: true, deleteBlock: { [weak self] indexPath in
            if let currentMilestones = self?.milestones {
                let milestone = currentMilestones[indexPath.row]
                self?.presenter.deleteMilestone(milestone)
            }
            }, configurationBlock: { [weak self] cell, milestone, indexPath in
                cell.binding(milestone: milestone)
                cell.isReadySwitch.tag = indexPath.row
                cell.isReadySwitch.addTarget(self, action: #selector(self?.onSwitchValueChanged(_:)), for: .touchUpInside)
        })
        tableView.dataSource = dataSource
        refreshControl.endRefreshing()
    }
    @objc private func onSwitchValueChanged(_ switchObject: UISwitch) {
        if let currentMilestones = milestones, let currentItem = item {
            let milestone = currentMilestones[switchObject.tag]
            presenter.updateMilestone(milestone, name: milestone.name ?? "", isDone: switchObject.isOn, item: currentItem)
        }
    }
}
extension SPCheckListViewController: SPCheckListDelegate {

    func didAddNewMilestone(name: String) {
        navigationController?.popViewController(animated: true)
        guard let currentItem = item else {
            return
        }
        let milestone = Milestone(uid: NSUUID().uuidString,
                                  isDone: false,
                                  name: name)
        presenter.addMilestone(milestone,
                               item: currentItem)
    }

    func didEditMilestone(name: String, milestone: Milestone) {
        navigationController?.popViewController(animated: true)
        guard let currentItem = item else {
            return
        }
        presenter.updateMilestone(milestone,
                                  name: name,
                                  isDone: milestone.isDone,
                                  item: currentItem)
    }
}
extension  SPCheckListViewController: SPCheckListPresenterProtocol {

    func show(milestones: [Milestone]) {
        self.milestones = milestones
    }

    func requestMilestones() {
        guard let itemUID = item?.uid else {
            return
        }
        presenter.getMilestones(itemUID: itemUID)
    }

    func didSuccessAction(_ message: String) {
        requestMilestones()
        showMessage(message)
    }

    func showError(_ message: String) {
        showMessage(message, title: "Error")
    }
}
