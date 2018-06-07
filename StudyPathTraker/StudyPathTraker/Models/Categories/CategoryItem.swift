//
//  CategoryItem.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 3/30/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import RealmSwift

class CategoryItem: Object {

    @objc dynamic var name: String?
    @objc dynamic var progress: Float = 0.0

    convenience init(name: String, progress: Float) {
        self.init()
        self.name = name
        self.progress = progress
    }
}
