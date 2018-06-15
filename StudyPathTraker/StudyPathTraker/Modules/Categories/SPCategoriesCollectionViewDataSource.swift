//
//  SPCategoriesCollectionViewDataSource.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 3/30/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit

class SPCategoriesCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    private let categoryCellReuseIdentifier: String = "CategoryCollectionCell"
    public var categories = [CategoryItem]()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellReuseIdentifier,
                                                            for: indexPath) as? SPCategoryCollectionViewCell else {
                                                                return UICollectionViewCell()
        }
        let item = categories[indexPath.row]
        cell.binding(category: item)
        return cell
    }

}
