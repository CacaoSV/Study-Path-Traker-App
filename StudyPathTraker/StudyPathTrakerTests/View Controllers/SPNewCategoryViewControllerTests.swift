//
//  SPNewCategoryViewControllerTests.swift
//  StudyPathTrakerTests
//
//  Created by Rafael Lopez on 6/20/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import XCTest
@testable import StudyPathTraker

class SPNewCategoryViewControllerTests: XCTestCase, SPCategoryPresenterProtocol {

    var newCategoryViewController: SPNewCategoryViewController!
    var categoryPresenter: SPCategoryPresenter = SPCategoryPresenter()
    var category: CategoryItem!
    var categories: [CategoryItem]!
    var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        newCategoryViewController = viewController(ofType: SPNewCategoryViewController.self,
                                                  from: StoryboardNames.Storyboards.collection.rawValue,
                                                  identifier: String(describing: SPNewCategoryViewController.self))
        _ = newCategoryViewController.view

        category = CategoryItem.newCategory(name: "Google")
        categories = [CategoryItem]()
        categoryPresenter.delegate = self
        expectation = XCTestExpectation(description: "Performance presenter")

    }
    
    override func tearDown() {
        newCategoryViewController = nil
        category = nil
        categories = nil
        expectation = nil
        super.tearDown()
    }

    func testConfigureViewToAddNewCategory() {
        XCTAssertEqual(newCategoryViewController.nameCategoryTextField.text, "")
        XCTAssertTrue(newCategoryViewController.deleteButton.isHidden)
        XCTAssertEqual(newCategoryViewController.addButton.titleLabel?.text, "ADD")
        XCTAssertEqual(newCategoryViewController.title, "Add New Category")
    }

    func testConfigureViewToEditCategory() {
        newCategoryViewController.newCategoryPresenter.addCategory(category)
        newCategoryViewController.category = category
        newCategoryViewController.isToEdit = true
        newCategoryViewController.viewDidLoad()
        XCTAssertEqual(newCategoryViewController.addButton.titleLabel?.text, "EDIT")
        XCTAssertFalse(newCategoryViewController.deleteButton.isHidden)
        XCTAssertEqual(newCategoryViewController.nameCategoryTextField.text, category.name)
        XCTAssertEqual(newCategoryViewController.title, "Edit Category")
    }

    func testAddCategory() {
        newCategoryViewController.nameCategoryTextField.text = "Facebook"
        newCategoryViewController.handleActionForCategory(categoryName: newCategoryViewController.nameCategoryTextField.text!)
        categoryPresenter.getCategories()
        wait(for: [expectation], timeout: 10.0)
        let lastCategory = categories[0]
        XCTAssertEqual(lastCategory.name, "Facebook")
        XCTAssertEqual(categories.count, 1)
    }

    func testDeleteCategory() {
        newCategoryViewController.newCategoryPresenter.addCategory(category)
        categoryPresenter.getCategories()
        XCTAssertEqual(categories.count, 1)
        newCategoryViewController.category = category
        newCategoryViewController.isToEdit = true
        newCategoryViewController.viewDidLoad()
        newCategoryViewController.performDeleteCategory()
        categoryPresenter.getCategories()
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(categories.count, 0)
    }

    func testEditCategory() {
        newCategoryViewController.newCategoryPresenter.addCategory(category)
        newCategoryViewController.category = category
        newCategoryViewController.isToEdit = true
        newCategoryViewController.viewDidLoad()
        newCategoryViewController.nameCategoryTextField.text = "Facebook"
        newCategoryViewController.handleActionForCategory(categoryName: newCategoryViewController.nameCategoryTextField.text!)
        categoryPresenter.getCategories()
        wait(for: [expectation], timeout: 10.0)
        let lastCategory = categories[0]
        XCTAssertEqual(lastCategory.name, "Facebook")
    }

    func show(categories: [CategoryItem]) {
        self.categories = categories
        expectation.fulfill()
    }

    func didSuccessAction(_ message: String) {
    }

    func showError(_ message: String) {
        expectation.fulfill()
    }
}
