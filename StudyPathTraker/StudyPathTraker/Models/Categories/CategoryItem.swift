//
//  CategoryItem.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 3/30/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import RealmSwift
import Realm

class CategoryItem: Object {

    @objc dynamic var name: String?
    @objc dynamic var progress: Float = 0.0
    @objc dynamic var uid: String = ""

    required init() {
        super.init()
    }
    
    convenience init(name: String, progress: Float, uid: String) {
        self.init()
        self.name = name
        self.progress = progress
        self.uid = uid
    }

    // MARK: - Realm Implementation
    override static func primaryKey() -> String? {
        return "uid"
    }

    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
