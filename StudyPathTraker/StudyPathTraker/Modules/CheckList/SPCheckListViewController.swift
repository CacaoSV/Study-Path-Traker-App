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
    var checkListPresenter: SPCheckListPresenter = SPCheckListPresenter()

    // MARK: - View Configuration

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Milestones"
        configureTableView()
        checkListPresenter.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMilestones()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newMilestoneViewController = segue.destination  as? SPNewCheckListViewController {
            newMilestoneViewController.item = item
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
        refreshControl.beginRefreshing()
        guard let itemUID = item?.uid else {
            return
        }
        checkListPresenter.getMilestones(itemUID: itemUID)
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
                self?.checkListPresenter.deleteMilestone(milestone)
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
        if let currentMilestones = milestones {
            let milestone = currentMilestones[switchObject.tag]
            checkListPresenter.updateMilestone(milestone, name: milestone.name ?? "", isDone: switchObject.isOn)
        }
    }
}
extension  SPCheckListViewController: SPCheckListPresenterProtocol {

    func show(milestones: [Milestone]) {
        self.milestones = milestones
    }

    func didSuccessAction(_ message: String) {
        getMilestones()
        showMessage(message)
    }

    func showError(_ message: String) {
        showMessage(message, title: "Error")
    }
}
