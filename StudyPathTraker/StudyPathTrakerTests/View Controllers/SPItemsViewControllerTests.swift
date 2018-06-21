//
//  SPItemsViewControllerTests.swift
//  StudyPathTrakerTests
//
//  Created by Rafael Lopez on 6/20/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import XCTest
@testable import StudyPathTraker

class SPItemsViewControllerTests: XCTestCase {

    var newCategoryPresenter: SPNewCategoryPresenter = SPNewCategoryPresenter()
    var newItemPresenter: SPNewItemPresenter = SPNewItemPresenter()

    var itemsViewController: SPItemsViewController!

    var category: CategoryItem!
    var items: [Item]!

    override func setUp() {
        super.setUp()

        itemsViewController = viewController(ofType: SPItemsViewController.self,
                                               from: StoryboardNames.Storyboards.collection.rawValue,
                                               identifier: String(describing: SPItemsViewController.self))
        _ = itemsViewController.view
        category = CategoryItem.newCategory(name: "Apple")
        newCategoryPresenter.addCategory(category)
        itemsViewController.category = category
        items = [Item.newItem(name: "Apple website", url: "https://www.apple.com/mx/"),
                 Item.newItem(name: "Bitly", url: "https://bitly.com/"),
                 Item.newItem(name: "Cocoa Controls", url: "https://www.cocoacontrols.com/")
        ]
        for item: Item in items {
            newItemPresenter.addNewItem(item, category: category)
        }
        itemsViewController.items = items
    }
    
    override func tearDown() {
        itemsViewController = nil
        category = nil
        items = nil
        PersistenceManager.deleteAllItems()
        super.tearDown()
    }

    func testSetItems() {
        itemsViewController.setItems(items)
        XCTAssertEqual(itemsViewController.dataSource?.tableView(itemsViewController.tableView, numberOfRowsInSection: 0), 3)
    }

    func testDeleteItem() {
        itemsViewController.setItems(items)
        let itemToDelete = items[0]
        itemsViewController.itemPresenter.deleteItem(item: itemToDelete)
        XCTAssertEqual(itemsViewController.dataSource?.tableView(itemsViewController.tableView, numberOfRowsInSection: 0), 2)
    }

    func testConfigurationView() {
        XCTAssertEqual(itemsViewController.title, "Readings")
        XCTAssertEqual(itemsViewController.tableView.rowHeight, 130.0)
        XCTAssertEqual(itemsViewController.view.backgroundColor, .mainBackground)
    }
}
