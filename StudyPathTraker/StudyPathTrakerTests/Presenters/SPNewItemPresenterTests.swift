//
//  SPNewItemPresenterTests.swift
//  StudyPathTrakerTests
//
//  Created by Rafael Lopez on 6/19/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import XCTest
@testable import StudyPathTraker

class SPNewItemPresenterTests: XCTestCase, SPNewItemPresenterProtocol, SPItemPresenterProtocol {

    var newItemPresenter: SPNewItemPresenter = SPNewItemPresenter()
    var newCategoryPresenter: SPNewCategoryPresenter = SPNewCategoryPresenter()
    var itemPresenter: SPItemPresenter = SPItemPresenter()

    var message: String!
    var category: CategoryItem!
    var item: Item!
    var items: [Item]!
    var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        expectation = XCTestExpectation(description: "Performance presenter")
        message = ""
        items = [Item]()
        newItemPresenter.delegate = self
        itemPresenter.delegate = self
        category = CategoryItem.newCategory(name: "Google")
        newCategoryPresenter.addCategory(category)
        item = Item.newItem(name: "Google", url: "https://www.google.com")
    }
    
    override func tearDown() {
        message = nil
        category = nil
        item = nil
        items = nil
        expectation = nil
        super.tearDown()
    }

    func testAddItem() {
        itemPresenter.getItems(categoryUID: category.uid)
        let lastItemsTotal = items.count
        newItemPresenter.addNewItem(item, category: category)
        wait(for: [expectation], timeout: 10.0)
        itemPresenter.getItems(categoryUID: category.uid)
        let newItemsTotal = items.count
        XCTAssertEqual(lastItemsTotal + 1, newItemsTotal)
        XCTAssertEqual(message, "Item succsessfully added")
    }

    func testEditItem() {
        itemPresenter.getItems(categoryUID: category.uid)
        newItemPresenter.addNewItem(item, category: category)
        newItemPresenter.updateItem(item, name: "Github", url: "https://www.github.com")
        itemPresenter.getItems(categoryUID: category.uid)
        let currentItem = items[0]
        XCTAssertEqual(currentItem.name, "Github")
        XCTAssertEqual(currentItem.url, "https://www.github.com")
        XCTAssertEqual(currentItem.uid, item.uid)
        XCTAssertEqual(message, "Item updated")
    }
    
    func didSuccessAction(_ message: String) {
        self.message = message
        expectation.fulfill()
    }

    func showError(_ message: String) {
        self.message = message
        expectation.fulfill()
    }

    func show(items: [Item]) {
        self.items = items
        expectation.fulfill()
    }
}
