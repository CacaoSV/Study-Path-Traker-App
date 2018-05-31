//
//  SPCategoriesCollectionViewFlowDelegate.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 4/30/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

struct CategoriesFlowConfiguration {
    let categoryEdgeInsets: UIEdgeInsets
    let cellHeight: Double
    let cellWidth: Double
    let itemsPerRow: Double
    let headerHeight: CGFloat
}

class SPCategoriesCollectionViewFlowDelegate: NSObject, UICollectionViewDelegateFlowLayout {

    private var categoryEdgeInsets: UIEdgeInsets
    private var cellHeight: Double
    private var cellWidth: Double
    private var itemsPerRow: Double
    private var headerHeight: CGFloat

    init(configuration: CategoriesFlowConfiguration) {
        self.cellHeight = configuration.cellHeight
        self.cellWidth = configuration.cellWidth
        self.itemsPerRow = configuration.itemsPerRow
        self.headerHeight = configuration.headerHeight
        self.categoryEdgeInsets = configuration.categoryEdgeInsets
    }

    public var selectedItemAction: ((_ itemPosition: Int) -> Void)?

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = Double(categoryEdgeInsets.left) * (itemsPerRow + 1)
        let availableWidth = Double(collectionView.frame.size.width) - padding
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = (cellHeight / cellWidth) * widthPerItem

        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItemAction?(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return categoryEdgeInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return categoryEdgeInsets.left
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let collectionViewWidth = collectionView.frame.size.width
        return CGSize(width: collectionViewWidth, height: headerHeight)
    }

}
