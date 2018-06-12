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

    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Properties

    private var categories = [CategoryItem]()
    var flowLayout: SPCategoriesCollectionViewFlowDelegate?
    fileprivate var categoriesDataSource = SPCategoriesCollectionViewDataSource()
    private var refreshControl = UIRefreshControl()

    var presenter: SPCategoryPresenter = SPCategoryPresenter()

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
        configureView()
        setupPresenter()
        title = "Categories"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newCategoryViewController = segue.destination  as? SPNewCategoryViewController {
            newCategoryViewController.delegate = self
        }
    }

    // MARK: View Configuration

    private func setupPresenter() {
        presenter.delegate = self
    }

    func configureView() {
        let addCategoryBarButton = UIBarButtonItem(image: UIImage(named: "ic_add_category"), style: .plain, target: self, action: #selector(showNewCategory(_:)))
        self.navigationItem.rightBarButtonItem = addCategoryBarButton
    }

    @objc func showNewCategory(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Segues.CategoriesSegues.showAddCategory.rawValue, sender: nil)
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
            // WIP Handle item selection
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
    func show(categories: [CategoryItem]) {
        self.categories = categories
    }

    func requestCategories() {
        presenter.getCategories()
    }

    func didAddNewCategorySuccess(_ message: String) {
        present(SPAlertCenter.showMessageWithTitle(message: message), animated: true, completion: nil)
    }
}
