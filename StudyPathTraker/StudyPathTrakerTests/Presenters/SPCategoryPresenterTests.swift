//
//  SPCategoryPresenterTests.swift
//  StudyPathTrakerTests
//
//  Created by Rafael Lopez on 6/12/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import XCTest
@testable import StudyPathTraker

class SPCategoryPresenterTests: XCTestCase, SPCategoryPresenterProtocol {

    var presenter: SPCategoryPresenter = SPCategoryPresenter()
    var expectation: XCTestExpectation!
    var categories: [CategoryItem]!

    override func setUp() {
        super.setUp()
        expectation = XCTestExpectation(description: "Performance presenter")
        presenter.delegate = self
        categories = [CategoryItem]()
        presenter.getCategories()
    }
    
    override func tearDown() {
        presenter.delegate = nil
        expectation = nil
        categories = nil
        super.tearDown()
    }

    func testAddNewCategory() {
        let lastCategories = categories
        presenter.addNewCategory(categoryName: "Test")
        wait(for: [expectation], timeout: 10.0)
        presenter.getCategories()
        XCTAssertEqual(categories.count, (lastCategories?.count)!+1)
    }

    func testDeleteItem() {
        let lastItem = categories.last
        let totalItems = categories.count
        presenter.deleteCategory(lastItem!)
        wait(for: [expectation], timeout: 10.0)
        presenter.getCategories()
        XCTAssertEqual(categories.count, totalItems-1)
    }

    func testUpdateItem() {
        let lastItem = categories.last
        presenter.updateCategoryName(name: "x", category: lastItem!)
        wait(for: [expectation], timeout: 10.0)
        presenter.getCategories()
        let updatedItem = categories.last
        XCTAssertEqual(updatedItem?.name, "x")
    }
    func didSuccessAction(_ message: String) {
        expectation.fulfill()
    }

    func show(categories: [CategoryItem]) {
        self.categories = categories
        expectation.fulfill()
    }

    func requestCategories() {
        expectation.fulfill()
    }

    func showError(_ message: String) {
        expectation.fulfill()
    }

}
