//
//  SPNewCheckListViewControllerTests.swift
//  StudyPathTrakerTests
//
//  Created by Rafael Lopez on 6/21/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import XCTest
@testable import StudyPathTraker

class SPNewCheckListViewControllerTests: XCTestCase, SPCheckListPresenterProtocol {

    var newItemPresenter: SPNewItemPresenter = SPNewItemPresenter()
    var newCategoryPresenter: SPNewCategoryPresenter = SPNewCategoryPresenter()
    var checkListPresenter: SPCheckListPresenter = SPCheckListPresenter()

    var newCheckListViewController: SPNewCheckListViewController!

    var category: CategoryItem!
    var item: Item!
    var milestone: Milestone!
    var milestones: [Milestone]!
    var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        category = CategoryItem.newCategory(name: "iOS")
        item = Item.newItem(name: "Cocoa Controls", url: "https://www.cocoacontrols.com/")
        milestone = Milestone.newMilestone(name: "Read All")
        checkListPresenter.delegate = self
        milestones = [Milestone]()
        expectation = XCTestExpectation(description: "Performance presenter")

        newCategoryPresenter.addCategory(category)
        newItemPresenter.addNewItem(item, category: category)

        newCheckListViewController = viewController(ofType: SPNewCheckListViewController.self,
                                               from: StoryboardNames.Storyboards.collection.rawValue,
                                               identifier: String(describing: SPNewCheckListViewController.self))
        newCheckListViewController.item = item
        _ = newCheckListViewController.view
    }
    
    override func tearDown() {
        item = nil
        category = nil
        milestones = nil
        expectation = nil
        newCheckListViewController = nil
        milestone = nil
        PersistenceManager.deleteAllItems()
        super.tearDown()
    }

    func testConfigureViewForNewMilestone() {
        XCTAssertEqual(newCheckListViewController.title, "Add New Milestone")
        XCTAssertEqual(newCheckListViewController.addNewButton.titleLabel?.text, "ADD")
        XCTAssertEqual(newCheckListViewController.nameMilestoneTextField.text, "")
        XCTAssertFalse(newCheckListViewController.isToEdit)
    }

    func testConfigureViewForEditMilestone() {
        newCheckListViewController.newCheckListPresenter.addMilestone(milestone, item: newCheckListViewController.item!)
        newCheckListViewController.isToEdit = true
        newCheckListViewController.milestone = milestone
        newCheckListViewController.viewWillAppear(true)
        XCTAssertEqual(newCheckListViewController.title, "Edit Milestone")
        XCTAssertEqual(newCheckListViewController.addNewButton.titleLabel?.text, "EDIT")
        XCTAssertEqual(newCheckListViewController.nameMilestoneTextField.text, milestone.name)
        XCTAssertTrue(newCheckListViewController.isToEdit)
    }

    func testAddNewMilestone() {
        newCheckListViewController.nameMilestoneTextField.text = milestone.name
        newCheckListViewController.handleActionForMilestone(name: newCheckListViewController.nameMilestoneTextField.text!)
        checkListPresenter.getMilestones(itemUID: item.uid)
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(milestones.count, 1)
    }

    func testEditMilestone() {
        newCheckListViewController.newCheckListPresenter.addMilestone(milestone, item: newCheckListViewController.item!)
        newCheckListViewController.isToEdit = true
        newCheckListViewController.milestone = milestone
        newCheckListViewController.viewWillAppear(true)
        newCheckListViewController.nameMilestoneTextField.text = "Create a diagram"
        newCheckListViewController.handleActionForMilestone(name: newCheckListViewController.nameMilestoneTextField.text!)
        checkListPresenter.getMilestones(itemUID: item.uid)
        wait(for: [expectation], timeout: 10.0)
        let lastMilestone = milestones[0]
        XCTAssertEqual(lastMilestone.name, newCheckListViewController.nameMilestoneTextField.text!)
        XCTAssertEqual(lastMilestone.uid, newCheckListViewController.milestone?.uid)
    }
    func show(milestones: [Milestone]) {
        self.milestones = milestones
        expectation.fulfill()
    }

    func didSuccessAction(_ message: String) {
        expectation.fulfill()
    }

    func showError(_ message: String) {
        expectation.fulfill()
    }
}
