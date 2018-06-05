//
//  SPCheckListViewController.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/4/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPCheckListViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var checkListTableViewDelegate: SPCommonTableViewDelegate! {
        didSet {
            checkListTableViewDelegate.selectedIndex = { [weak self] index in
               // WIP Handle cell selection
            }
        }
    }

    // MARK: - Properties

    var item: Item?
    private var dataSource: SPCommonTableViewDataSource<Milestone, SPCheckListTableViewCell>?
    private var refreshControl = UIRefreshControl()
    private var milestones: [Milestone] = [] {
        didSet {
            setMilestones()
        }
    }
    private let cellConfiguration = SPCommonCellConfiguration(identifier: "CheckListCellIdentifier", height: 70.0)

    // MARK: - View Configuration

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Milestones"
        milestones = item?.milestones ?? []
        configureTableView()
    }

    // MARK: - Functions

    private  func configureTableView() {
        tableView.backgroundColor = .mainBackground
        tableView.rowHeight = cellConfiguration.height
        refreshControl.attributedTitle = NSAttributedString(string: "Loading milestones")
        refreshControl.addTarget(self, action: #selector(setMilestones), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc private func setMilestones() {
        dataSource = SPCommonTableViewDataSource<Milestone, SPCheckListTableViewCell>(data: milestones, reuseIdentifier: cellConfiguration.identifier) { cell, milestone, _ in
            cell.binding(milestone: milestone)
        }
        tableView.dataSource = dataSource
        refreshControl.endRefreshing()
    }
}
