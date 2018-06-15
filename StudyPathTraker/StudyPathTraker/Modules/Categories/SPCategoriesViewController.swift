//
//  SPCategoriesViewController.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 3/30/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPCategoriesViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties

    private var categories = [CategoryItem]()
    var flowLayout: SPCategoriesCollectionViewFlowDelegate?
    fileprivate var categoriesDataSource = SPCategoriesCollectionViewDataSource()
    var refreshControl = UIRefreshControl()
    var presenter: SPCategoryPresenter = SPCategoryPresenter()
    private var categorySelected: CategoryItem?

    // MARK: - View Controller LifeCycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setRefreshControl()
        setUpCollectionView()
        requestCategories()
        loadCategories()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        title = "Categories"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newCategoryViewController = segue.destination  as? SPNewCategoryViewController {
            newCategoryViewController.delegate = self
        } else if let itemsViewController = segue.destination as? SPItemsViewController {
            itemsViewController.category = categorySelected
        }
    }

    // MARK: View Configuration

    private func setupPresenter() {
        presenter.delegate = self
    }

    func setRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Loading categories")
        refreshControl.addTarget(self, action: #selector( refreshList(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
    }

    private func setUpCollectionView() {
        let edgeInsects = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let configuration = CategoriesFlowConfiguration(categoryEdgeInsets: edgeInsects,
                                                        cellHeight: 165,
                                                        cellWidth: 140,
                                                        itemsPerRow: 2,
                                                        headerHeight: 10)
            flowLayout = SPCategoriesCollectionViewFlowDelegate(configuration: configuration)
        flowLayout?.selectedItemAction = { [weak self] index in
            self?.categorySelected = self?.categories[index]
            self?.performSegue(withIdentifier: Segues.CategoriesSegues.showItems.rawValue, sender: nil)
        }
        collectionView.dataSource = categoriesDataSource
        collectionView.delegate = flowLayout
    }

    @objc private func refreshList(_ sender: Any) {
        requestCategories()
        loadCategories()
    }

    private func loadCategories() {
        refreshControl.beginRefreshing()
        categoriesDataSource.categories = categories
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
}
extension SPCategoriesViewController: SPCategoryDelegate {

    func didAddNewCategory(name: String) {
        presenter.addNewCategory(categoryName: name)
    }
}
extension SPCategoriesViewController: SPCategoryPresenterProtocol {
    func didSuccessAction(_ message: String) {
        refreshList(self)
        showMessage(message)
    }

    func showError(_ message: String) {
        showMessage(message, title: "Error")
    }

    func show(categories: [CategoryItem]) {
        self.categories = categories
    }

    func requestCategories() {
        presenter.getCategories()
    }
}
