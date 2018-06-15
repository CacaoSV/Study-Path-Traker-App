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
        getItems()
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(updateItem(longPressGestureRecognizer:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination  as? SPDetailViewController {
            detailViewController.item = selectedItem
        }

        if let newItemViewController = segue.destination  as? SPNewItemViewController {
            newItemViewController.delegate = self
            if let itemToUpdate = selectedItem {
                newItemViewController.item = itemToUpdate
                newItemViewController.isToEdit = true
            }
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
        requestItems()
    }
}
extension SPItemsViewController: SPItemDelegate {
    func didEditItem(name: String, url: String, item: Item?) {
        navigationController?.popViewController(animated: true)
        guard let updatedItem = item else {
            return
        }
        presenter.updateItem(item: updatedItem, name: name, url: url)
    }

    func didAddNewItem(name: String, url: String) {
        guard let currentCategory = category else {
            return
        }
        navigationController?.popViewController(animated: true)
        let item = Item(uid: NSUUID().uuidString, name: name, progress: 0.0, url: url, milestones: [Milestone]())
        presenter.addNewItem(item: item, category: currentCategory)
        requestItems()
    }
}
extension SPItemsViewController: SPItemPresenterProtocol {
    func show(items: [Item]) {
        self.items = items
    }

    func requestItems() {
        if let categoryUID = category?.uid {
            presenter.getItems(categoryUID: categoryUID)
        }
    }

    func didSuccessAction(_ message: String) {
        requestItems()
        showMessage(message)
    }

    func showError(_ message: String) {
        showMessage(message, title: "Error")
    }
}
