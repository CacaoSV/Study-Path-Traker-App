//
//  SPItemPresenterTests.swift
//  StudyPathTrakerTests
//
//  Created by Rafael Lopez on 6/19/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import XCTest
@testable import StudyPathTraker

class SPItemPresenterTests: XCTestCase, SPItemPresenterProtocol {

    var itemPresenter: SPItemPresenter = SPItemPresenter()
    var newCategoryPresenter: SPNewCategoryPresenter = SPNewCategoryPresenter()
    var newItemPresenter: SPNewItemPresenter = SPNewItemPresenter()

    var expectation: XCTestExpectation!
    var items: [Item]!
    var category: CategoryItem!
    var item: Item!

    override func setUp() {
        super.setUp()
        expectation = XCTestExpectation(description: "Performance presenter")
        itemPresenter.delegate = self
        items = [Item]()
        category = CategoryItem.newCategory(name: "Test")
        item = Item.newItem(name: "Google", url: "https://www.google.com")
    }

    override func tearDown() {
        expectation = nil
        items = nil
        category = nil
        super.tearDown()
    }

    func testGetItemsAllItems() {
        newCategoryPresenter.addCategory(category)
        newItemPresenter.addNewItem(item, category: category)
        itemPresenter.getItems(categoryUID: category.uid)
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(items)
    }

    func testDeleteItem() {
        newCategoryPresenter.addCategory(category)
        newItemPresenter.addNewItem(item, category: category)
        newItemPresenter.addNewItem(Item.newItem(name: "Android", url: "https://www.google.com"), category: category)
        itemPresenter.getItems(categoryUID: category.uid)
        let totalItems = items.count
        itemPresenter.deleteItem(item: item)
        itemPresenter.getItems(categoryUID: category.uid)
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(items.count, totalItems-1)
    }

    func didSuccessAction(_ message: String) {
        expectation.fulfill()
    }

    func showError(_ message: String) {
        expectation.fulfill()
    }

    func show(items: [Item]) {
        self.items = items
        expectation.fulfill()
    }
}
