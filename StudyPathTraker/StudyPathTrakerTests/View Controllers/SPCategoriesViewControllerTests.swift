//
//  SPCategoriesViewControllerTests.swift
//  StudyPathTrakerTests
//
//  Created by Rafael Lopez on 6/12/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import XCTest
@testable import StudyPathTraker

class SPCategoriesViewControllerTests: XCTestCase {

    var categoriesViewController: SPCategoriesViewController!
    var edgeInsects: UIEdgeInsets!
    var configurationFlow: CategoriesFlowConfiguration!

    override func setUp() {
        super.setUp()
        categoriesViewController = viewController(ofType: SPCategoriesViewController.self,
                                                  from: StoryboardNames.Storyboards.collection.rawValue,
                                                  identifier: String(describing: SPCategoriesViewController.self))
        _ = categoriesViewController.view
        edgeInsects = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        configurationFlow  = CategoriesFlowConfiguration(categoryEdgeInsets: edgeInsects,
                                                        cellHeight: 165,
                                                        cellWidth: 140,
                                                        itemsPerRow: 2,
                                                        headerHeight: 10)
    }
    
    override func tearDown() {
        categoriesViewController = nil
        edgeInsects = nil
        configurationFlow = nil
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertNotNil(categoriesViewController.presenter)
    }

    func testFlowLayout() {
        categoriesViewController.viewWillAppear(true)
        XCTAssertNotNil(categoriesViewController.flowLayout)

        let edgeInsectsTest: UIEdgeInsets = (categoriesViewController.flowLayout?.collectionView(categoriesViewController.collectionView, layout: UICollectionViewLayout(), insetForSectionAt: 0))!
        XCTAssertEqual(edgeInsectsTest, edgeInsects)

        let minimumSpacing = categoriesViewController.flowLayout?.collectionView(categoriesViewController.collectionView, layout: UICollectionViewLayout(), minimumLineSpacingForSectionAt: 0)
        XCTAssertEqual(minimumSpacing, edgeInsectsTest.left)

        let headerInsection = categoriesViewController.flowLayout?.collectionView(categoriesViewController.collectionView, layout: UICollectionViewLayout(), referenceSizeForHeaderInSection: 0)
        let collectionViewWidth = categoriesViewController.collectionView.frame.size.width
        XCTAssertEqual(headerInsection, CGSize(width: collectionViewWidth, height: configurationFlow.headerHeight))
    }
}
