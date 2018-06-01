//
//  SPItemsViewController.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 5/31/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPItemsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var itemsTableViewDelegate: SPItemsTableViewDelegate! {
        didSet {
            itemsTableViewDelegate.selectedIndex = { [weak self] index in
                // WIP Handle item selection
            }
        }
    }
    
    // MARK: - Properties
    private var dataSource: SPCommonTableViewDataSource<Item, SPItemTableViewCell>?
    private var refreshControl = UIRefreshControl()
    private var items: [Item]? {
        didSet {
            if let settedItems = items {
                setItems(settedItems)
            }
        }
    }
    private let cellConfiguration = SPCommonCellConfiguration(identifier: "ItemCellIdentifier", height: 130.0)

    // MARK: - View Configuration

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Readings"
        view.backgroundColor = .mainBackground
        configureTableView()
        getItems()
    }

    // MARK: - Functions

    private func configureTableView() {
        tableView.backgroundColor = .mainBackground
        tableView.rowHeight = cellConfiguration.height
        refreshControl.attributedTitle = NSAttributedString(string: "Loading readings")
        refreshControl.addTarget(self, action: #selector(getItems), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func setItems(_ items: [Item]) {
        dataSource = SPCommonTableViewDataSource<Item, SPItemTableViewCell>(data: items, reuseIdentifier: cellConfiguration.identifier) { cell, item, _ in
            cell.binding(item: item)
        }
        tableView.dataSource = dataSource
        refreshControl.endRefreshing()
    }

    @objc private func getItems() {
        refreshControl.beginRefreshing()
        items = [Item(name: "Configure fork", progress: 1.0, url: "https://help.github.com/articles/configuring-a-remote-for-a-fork/"),
                 Item(name: "Sync fork", progress: 0.5, url: "https://help.github.com/articles/syncing-a-fork/")
        ]
    }
}
