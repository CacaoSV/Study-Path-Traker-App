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
    @IBOutlet private var itemsTableViewDelegate: SPCommonTableViewDelegate! {
        didSet {
            itemsTableViewDelegate.selectedIndex = { [weak self] index in
                self?.selectedItem = self?.items?[index]
                self?.performSegue(withIdentifier: Segues.ItemsSegues.showDetail.rawValue, sender: nil)
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
    private var selectedItem: Item?
    var category: CategoryItem?
    var presenter: SPItemPresenter = SPItemPresenter()

    // MARK: - View Configuration

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Readings"
        view.backgroundColor = .mainBackground
        presenter.delegate = self
        configureTableView()
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(updateItem(longPressGestureRecognizer:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getItems()
        selectedItem = nil
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination  as? SPDetailViewController {
            detailViewController.item = selectedItem
        }

        if let newItemViewController = segue.destination  as? SPNewItemViewController {
            guard let currentCategory = category else {
                return
            }
            if let itemToUpdate = selectedItem {
                newItemViewController.item = itemToUpdate
                newItemViewController.isToEdit = true
            }
            newItemViewController.category = currentCategory
        }
    }

    // MARK: - Functions

    @objc private func configureTableView() {
        tableView.backgroundColor = .mainBackground
        tableView.rowHeight = cellConfiguration.height
        refreshControl.attributedTitle = NSAttributedString(string: "Loading readings")
        refreshControl.addTarget(self, action: #selector(getItems), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc func updateItem(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == .began {
            let touchPoint = longPressGestureRecognizer.location(in: view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint), let currentItems = items {
                selectedItem = currentItems[indexPath.row]
                performSegue(withIdentifier: Segues.ItemsSegues.showAddItem.rawValue, sender: nil)
            }
        }
    }

    private func setItems(_ items: [Item]) {
        dataSource = SPCommonTableViewDataSource<Item, SPItemTableViewCell>(data: items, reuseIdentifier: cellConfiguration.identifier, deleteAllowed: true, deleteBlock: { [weak self] indexPath in
            let item = items[indexPath.row]
            self?.presenter.deleteItem(item: item)
        }, configurationBlock: { cell, item, _ in
            cell.binding(item: item)
        })
        tableView.dataSource = dataSource
        refreshControl.endRefreshing()
    }

    @objc private func getItems() {
        refreshControl.beginRefreshing()
        if let categoryUID = category?.uid {
            presenter.getItems(categoryUID: categoryUID)
        }
    }
}
extension SPItemsViewController: SPItemPresenterProtocol {
    func show(items: [Item]) {
        self.items = items
    }

    func didSuccessAction(_ message: String) {
        getItems()
        showMessage(message)
    }

    func showError(_ message: String) {
        showMessage(message, title: "Error")
    }
}
