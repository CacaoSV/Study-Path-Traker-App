//
//  SPNewItemViewControllerTests.swift
//  StudyPathTrakerTests
//
//  Created by Rafael Lopez on 6/20/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import XCTest
@testable import StudyPathTraker

class SPNewItemViewControllerTests: XCTestCase, SPItemPresenterProtocol {

    var itemPresenter: SPItemPresenter = SPItemPresenter()
    var newCategoryPresenter: SPNewCategoryPresenter = SPNewCategoryPresenter()

    var newItemViewController: SPNewItemViewController!

    var category: CategoryItem!
    var item: Item!
    var items: [Item]!
    var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        newItemViewController = viewController(ofType: SPNewItemViewController.self,
                                                  from: StoryboardNames.Storyboards.collection.rawValue,
                                                  identifier: String(describing: SPNewItemViewController.self))
        _ = newItemViewController.view

        expectation = XCTestExpectation(description: "Performance presenter")
        category = CategoryItem.newCategory(name: "Google")
        item = Item.newItem(name: "Google", url: "https://www.google.com")
        items = [Item]()
        itemPresenter.delegate = self
    }
    
    override func tearDown() {
        newItemViewController = nil
        expectation = nil
        items = nil
        item = nil
        category = nil
        PersistenceManager.deleteAllItems()
        super.tearDown()
    }

    func testAddNewItem() {
        newCategoryPresenter.addCategory(category)
        newItemViewController.urlTextField.text = "https://www.google.com"
        newItemViewController.nameTextField.text = "Google"
        newItemViewController.category = category
        newItemViewController.createItem(name: newItemViewController.nameTextField.text!,
                                         url: newItemViewController.urlTextField.text!)
        itemPresenter.getItems(categoryUID: category.uid)
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(items.count, 1)
    }

    func testUpdateItemOnlyName() {
        newCategoryPresenter.addCategory(category)
        newItemViewController.category = category
        newItemViewController.newItemPresenter.addNewItem(item, category: category)
        newItemViewController.item = item
        newItemViewController.nameTextField.text = "Facebook"
        newItemViewController.editItem(name: newItemViewController.nameTextField.text!,
                                       url: item.url!)
        itemPresenter.getItems(categoryUID: category.uid)
        wait(for: [expectation], timeout: 10.0)
        let lastItem = items[0]
        XCTAssertEqual(lastItem.name, "Facebook")
    }

    func testUpdateItemOnlyUrl() {
        newCategoryPresenter.addCategory(category)
        newItemViewController.category = category
        newItemViewController.newItemPresenter.addNewItem(item, category: category)
        newItemViewController.item = item
        newItemViewController.urlTextField.text = "https://www.facebook.com"
        newItemViewController.editItem(name: item.name!,
                                       url: newItemViewController.urlTextField.text!)
        itemPresenter.getItems(categoryUID: category.uid)
        wait(for: [expectation], timeout: 10.0)
        let lastItem = items[0]
        XCTAssertEqual(lastItem.url, "https://www.facebook.com")
    }

    func testConfigureView() {
        XCTAssertEqual(newItemViewController.nameTextField.text, "")
        XCTAssertEqual(newItemViewController.urlTextField.text, "")
        XCTAssertEqual(newItemViewController.addButton.titleLabel?.text, "ADD")
    }

    func testConfigureViewToEdit() {
        newItemViewController.isToEdit = true
        newItemViewController.item = item
        newItemViewController.viewWillAppear(true)
        XCTAssertEqual(newItemViewController.nameTextField.text, item.name!)
        XCTAssertEqual(newItemViewController.urlTextField.text, item.url!)
        XCTAssertEqual(newItemViewController.title, "Edit Item")
        XCTAssertEqual(newItemViewController.addButton.titleLabel?.text, "EDIT")
    }

    func show(items: [Item]) {
        self.items = items
        expectation.fulfill()
    }

    func didSuccessAction(_ message: String) {
        expectation.fulfill()
    }

    func showError(_ message: String) {
        expectation.fulfill()
    }
}
