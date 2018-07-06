//
//  SPNewCheckListPresenterTests.swift
//  StudyPathTrakerTests
//
//  Created by Rafael Lopez on 6/20/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import XCTest
@testable import StudyPathTraker

class SPNewCheckListPresenterTests: XCTestCase, SPNewCheckListPresenterProtocol {
    var newCategoryPresenter: SPNewCategoryPresenter = SPNewCategoryPresenter()
    var newItemPresenter: SPNewItemPresenter = SPNewItemPresenter()
    var newCheckListPresenter: SPNewCheckListPresenter = SPNewCheckListPresenter()


    var category: CategoryItem!
    var item: Item!
    var milestone: Milestone!
    var message: String!
    var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        category = CategoryItem.newCategory(name: "Google")
        item = Item.newItem(name: "Google", url: "https://www.google.com")
        milestone = Milestone.newMilestone(name: "Read full article")
        message = ""
        expectation = XCTestExpectation(description: "Performance presenter")

        newCheckListPresenter.delegate = self

        newCategoryPresenter.addCategory(category)
        newItemPresenter.addNewItem(item, category: category)
    }
    
    override func tearDown() {
        category = nil
        item = nil
        message = nil
        expectation = nil
        super.tearDown()
    }

    func testAddMilestone() {
        newCheckListPresenter.addMilestone(milestone, item: item)
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(item.milestones.count, 1)
        XCTAssertEqual(message, "Milestone succsessfully added")
    }

    func testUpdateMilestone() {
        newCheckListPresenter.addMilestone(milestone, item: item)
        newCheckListPresenter.updateMilestone(milestone, name: "Material")
        wait(for: [expectation], timeout: 10.0)
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

}
