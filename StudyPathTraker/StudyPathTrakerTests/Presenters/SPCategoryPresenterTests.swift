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

    var categoryPresenter: SPCategoryPresenter = SPCategoryPresenter()
    var expectation: XCTestExpectation!
    var categories: [CategoryItem]!

    override func setUp() {
        super.setUp()
        expectation = XCTestExpectation(description: "Performance presenter")
        categoryPresenter.delegate = self
        categories = [CategoryItem]()
        categoryPresenter.getCategories()
    }
    
    override func tearDown() {
        categoryPresenter.delegate = nil
        expectation = nil
        categories = nil
        super.tearDown()
    }

    func testGetCategories() {
        categoryPresenter.getCategories()
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(categories)
    }
    
    func didSuccessAction(_ message: String) {
        expectation.fulfill()
    }

    func show(categories: [CategoryItem]) {
        self.categories = categories
        expectation.fulfill()
    }

    func showError(_ message: String) {
        expectation.fulfill()
    }

}
