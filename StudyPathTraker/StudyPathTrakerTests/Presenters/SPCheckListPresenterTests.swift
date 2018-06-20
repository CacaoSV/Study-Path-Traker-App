//
//  SPCheckListPresenterTests.swift
//  StudyPathTrakerTests
//
//  Created by Rafael Lopez on 6/20/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import XCTest
@testable import StudyPathTraker

class SPCheckListPresenterTests: XCTestCase, SPCheckListPresenterProtocol {

    var newCategoryPresenter: SPNewCategoryPresenter = SPNewCategoryPresenter()
    var newItemPrenter: SPNewItemPresenter = SPNewItemPresenter()
    var newCheckListPresenter: SPNewCheckListPresenter = SPNewCheckListPresenter()
    var checkListPresenter: SPCheckListPresenter = SPCheckListPresenter()

    var category: CategoryItem!
    var item: Item!
    var milestone: Milestone!
    var milestones: [Milestone]!
    var message: String!
    var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        category = CategoryItem.newCategory(name: "Google")
        item = Item.newItem(name: "Google", url: "https://www.google.com")
        milestone = Milestone.newMilestone(name: "Read full article")

        message = ""
        expectation = XCTestExpectation(description: "Performance presenter")
        milestones = [Milestone]()
        newCategoryPresenter.addCategory(category)
        newItemPrenter.addNewItem(item, category: category)
        newCheckListPresenter.addMilestone(milestone, item: item)

        checkListPresenter.delegate = self
    }
    
    override func tearDown() {
        category = nil
        item = nil
        milestone = nil
        message = ""
        expectation = nil
        milestones = nil
        super.tearDown()
    }

    func testGetMilestones() {
        checkListPresenter.getMilestones(itemUID: item.uid)
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(milestones.count, 1)
    }

    func testDeleteMilestone() {
        checkListPresenter.deleteMilestone(milestone)
        wait(for: [expectation], timeout: 10.0)
        checkListPresenter.getMilestones(itemUID: item.uid)
        XCTAssertEqual(milestones.count, 0)
        XCTAssertEqual(message, "Milestone deleted")
    }

    func testUpdateMilestoneOnlyName() {
        checkListPresenter.updateMilestone(milestone, name: "Material")
        wait(for: [expectation], timeout: 10.0)
        checkListPresenter.getMilestones(itemUID: item.uid)
        let milestoneUpdated = milestones[0]
        XCTAssertEqual(milestoneUpdated.name, "Material")
        XCTAssertEqual(message, "Item updated")
    }

    func testUpdateMilestoneWithStatus() {
        checkListPresenter.updateMilestone(milestone, name: "Material", isDone: true)
        wait(for: [expectation], timeout: 10.0)
        checkListPresenter.getMilestones(itemUID: item.uid)
        let milestoneUpdated = milestones[0]
        XCTAssertEqual(message, "Item updated")
        XCTAssertTrue(milestoneUpdated.isDone)
    }

    func show(milestones: [Milestone]) {
        self.milestones = milestones
        expectation.fulfill()
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
