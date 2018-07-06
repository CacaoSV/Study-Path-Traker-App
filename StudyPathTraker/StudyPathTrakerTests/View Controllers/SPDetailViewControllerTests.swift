//
//  SPDetailViewControllerTests.swift
//  StudyPathTrakerTests
//
//  Created by Rafael Lopez on 6/20/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import XCTest
@testable import StudyPathTraker

class SPDetailViewControllerTests: XCTestCase {

    var detailViewController: SPDetailViewController!

    var item: Item!

    override func setUp() {
        super.setUp()

        item = Item.newItem(name: "Google", url: "https://www.google.com/")
        detailViewController = viewController(ofType: SPDetailViewController.self,
                                               from: StoryboardNames.Storyboards.collection.rawValue,
                                               identifier: String(describing: SPDetailViewController.self))
        detailViewController.item = item
        _ = detailViewController.view
    }
    
    override func tearDown() {
        detailViewController = nil
        item = nil
        super.tearDown()
    }

    func testConfigureView() {
        detailViewController.configureView()
        XCTAssertEqual(detailViewController.title, item.name)
        XCTAssertEqual(detailViewController.totalProgressView.progress, item.progress)
    }

    func testConfigureWebView() {
        detailViewController.configureWebView()
        XCTAssertEqual(detailViewController.webView.url?.absoluteString, item.url)
    }

    func testRemoveActivityIndicator() {
        detailViewController.activityIndicatorView.startAnimating()
        detailViewController.activityIndicatorView.isHidden = false
        detailViewController.removeActivityIndicator()
        XCTAssertFalse(detailViewController.activityIndicatorView.isAnimating)
        XCTAssertTrue(detailViewController.activityIndicatorView.isHidden)
    }
}
