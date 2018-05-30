//
//  SPCategoriesCollectionViewFlowDelegate.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 4/30/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit


class SPCategoriesCollectionViewFlowDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    
    private let categoryEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    private let cellHeight = 165.0
    private let cellWidth = 140.0
    private let itemsPerRow = 2.0
    private let headerHeight = 10
    
    public var selectedItemAction: ((_ itemPosition: Int) -> Void)?
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = Double(categoryEdgeInsets.left) * (itemsPerRow + 1)
        let availableWidth = Double(collectionView.frame.size.width) - padding
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = (cellHeight / cellWidth) * widthPerItem
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let itemSelected = selectedItemAction {
            itemSelected(indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return categoryEdgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return categoryEdgeInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let collectionViewWidth = collectionView.frame.size.width
        return CGSize(width: Int(collectionViewWidth), height: headerHeight)
    }
    
}
