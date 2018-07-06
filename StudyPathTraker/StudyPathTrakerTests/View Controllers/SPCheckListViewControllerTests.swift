//
//  SPCheckListViewControllerTests.swift
//  StudyPathTrakerTests
//
//  Created by Rafael Lopez on 6/21/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import XCTest
@testable import StudyPathTraker

class SPCheckListViewControllerTests: XCTestCase {

    var newCategoryPresenter: SPNewCategoryPresenter = SPNewCategoryPresenter()
    var newItemPresenter: SPNewItemPresenter = SPNewItemPresenter()
    var newCheckListPresenter: SPNewCheckListPresenter = SPNewCheckListPresenter()

    var item: Item!
    var category: CategoryItem!
    var milestone: Milestone!
    var milestones: [Milestone]!

    var checkListViewController: SPCheckListViewController!
    var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        category = CategoryItem.newCategory(name: "Apple")
        item = Item.newItem(name: "Apple website", url: "https://www.apple.com/mx/")
        milestone = Milestone.newMilestone(name: "Read all")
        milestones = [Milestone]()

        newCategoryPresenter.addCategory(category)
        newItemPresenter.addNewItem(item, category: category)
        newCheckListPresenter.addMilestone(milestone, item: item)
        expectation = XCTestExpectation(description: "Performance presenter")

        checkListViewController = viewController(ofType: SPCheckListViewController.self,
                                                    from: StoryboardNames.Storyboards.collection.rawValue,
                                                    identifier: String(describing: SPCheckListViewController.self))
        checkListViewController.item = item
        _ = checkListViewController.view
    }
    
    override func tearDown() {
        category = nil
        item = nil
        milestones = nil
        milestone = nil

        super.tearDown()
    }

    func testUpdateMilestone() {
        let switchObject = UISwitch.init()
        switchObject.tag = 0
        switchObject.isOn = true
        checkListViewController.getMilestones()
        checkListViewController.onSwitchValueChanged(switchObject)
        let lastMilestone = checkListViewController.milestones![0]
        XCTAssertTrue(lastMilestone.isDone)
    }

    func testGetMilestones() {
        checkListViewController.getMilestones()
        XCTAssertEqual(checkListViewController.milestones?.count, 1)
    }
}
