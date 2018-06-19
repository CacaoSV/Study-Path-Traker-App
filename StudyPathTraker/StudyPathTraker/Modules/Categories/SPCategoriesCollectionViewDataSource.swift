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
    public var selectedUpdateItemAction: ((_ itemPosition: Int) -> Void)?

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
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(tappedEditButton(sender:)), for: .touchUpInside)
        return cell
    }

    @objc private func tappedEditButton(sender: SPRoundedButton) {
        selectedUpdateItemAction?(sender.tag)
    }
}
