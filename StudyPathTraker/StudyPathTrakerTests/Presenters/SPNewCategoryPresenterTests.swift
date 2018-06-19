//
//  SPNewCategoryPresenterTests.swift
//  StudyPathTrakerTests
//
//  Created by Rafael Lopez on 6/19/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import XCTest
@testable import StudyPathTraker

class SPNewCategoryPresenterTests: XCTestCase, SPNewCategoryPresenterProtocol, SPCategoryPresenterProtocol {

    var categoryPresenter: SPCategoryPresenter = SPCategoryPresenter()
    var newCategoryPresenter: SPNewCategoryPresenter = SPNewCategoryPresenter()
    var expectation: XCTestExpectation!
    var category: CategoryItem!
    var message: String!
    var categories: [CategoryItem]!

    override func setUp() {
        super.setUp()
        newCategoryPresenter.delegate = self
        categoryPresenter.delegate = self
        expectation = XCTestExpectation(description: "Performance presenter")
        category = CategoryItem.newCategory(name: "Test")
        message = ""
        categories = [CategoryItem]()
    }
    
    override func tearDown() {
        expectation = nil
        category = nil
        message = nil
        categories = nil
        super.tearDown()
    }

    func testAddCategory() {
        newCategoryPresenter.addCategory(category)
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(message, "Category succsessfully added")
    }

    func testDeleteItem() {
        newCategoryPresenter.addCategory(CategoryItem.newCategory(name: "Test"))
        newCategoryPresenter.addCategory(CategoryItem.newCategory(name: "Test"))
        categoryPresenter.getCategories()
        let lastItem = categories.last
        let totalItems = categories.count
        newCategoryPresenter.deleteCategory(lastItem!)
        wait(for: [expectation], timeout: 10.0)
        categoryPresenter.getCategories()
        XCTAssertEqual(categories.count, totalItems-1)
    }


    func testUpdateCategoryName() {
        newCategoryPresenter.updateCategoryName(name: "Test 2", category: category)
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(message, "Category updated")
    }

    func didSuccessAction(_ message: String) {
        self.message = message
        expectation.fulfill()
    }

    func showError(_ message: String) {
        expectation.fulfill()
    }

    func show(categories: [CategoryItem]) {
        self.categories = categories
    }
}
