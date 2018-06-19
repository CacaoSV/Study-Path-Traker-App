//
//  Category+Extensions.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/19/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import Foundation

extension CategoryItem {
    static func newCategory(name: String) -> CategoryItem {
        return CategoryItem(name: name,
                            progress: 0.0,
                            uid: NSUUID().uuidString,
                            items: [Item]()
        )
    }
}
