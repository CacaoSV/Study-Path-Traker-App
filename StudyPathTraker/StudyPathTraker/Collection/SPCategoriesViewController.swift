//
//  SPCategoriesViewController.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 3/30/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPCategoriesViewController: UIViewController {
    
    @IBOutlet weak var flowLayout: SPCategoriesCollectionViewFlowDelegate! {
        didSet {
            flowLayout.selectedItemAction = { [weak self] index in
                //WIP Handle item selection
            }
        }
    }
    fileprivate var categoriesDataSource = SPCategoriesCollectionViewDataSource()
    private var refreshControl = UIRefreshControl()
    @IBOutlet weak var collectionView: UICollectionView!
    private var categories = [CategoryItem]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Categories"
        setRefreshControl()
        setUpCollectionView()
        loadCategories()
    }
    
    //MARK: View Configuration

    func setRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Loading categories")
        refreshControl.addTarget(self, action: #selector( refreshList(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
    }
    
    private func setUpCollectionView() {
        flowLayout.selectedItemAction = { [weak self] index in
            //WIP Handle item selection
        }
        collectionView.dataSource = categoriesDataSource
        collectionView.delegate = flowLayout
    }
    
    @objc private func refreshList(_ sender: Any) {
        loadCategories()
    }
    
    private func loadCategories() {
        refreshControl.beginRefreshing()
        categories = [CategoryItem(name: "iOS Stuffs", progress: 0.5),
                      CategoryItem(name: "Android Stuffs", progress: 0.1),
                      CategoryItem(name: "Web Stuffs", progress: 0.8)
        ]
        categoriesDataSource.categories = categories
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
}
