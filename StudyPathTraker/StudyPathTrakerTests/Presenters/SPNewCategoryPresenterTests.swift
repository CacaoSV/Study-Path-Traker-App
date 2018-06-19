//
//  SPNewCategoryPresenterTests.swift
//  StudyPathTrakerTests
//
//  Created by Rafael Lopez on 6/19/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import XCTest
@testable import StudyPathTraker

class SPNewCategoryPresenterTests: XCTestCase, SPNewCategoryPresenterProtocol {
    var presenter: SPNewCategoryPresenter = SPNewCategoryPresenter()
    var expectation: XCTestExpectation!
    var category: CategoryItem!
    var message: String!

    override func setUp() {
        super.setUp()
        presenter.delegate = self
        expectation = XCTestExpectation(description: "Performance presenter")
        category = CategoryItem.newCategory(name: "Test")
        message = ""
    }
    
    override func tearDown() {
        expectation = nil
        category = nil
        message = nil
        super.tearDown()
    }

    func testAddCategory() {
        presenter.addCategory(category)
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(message, "Category succsessfully added")
    }

    func testUpdateCategoryName() {
        presenter.updateCategoryName(name: "Test 2", category: category)
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
}
