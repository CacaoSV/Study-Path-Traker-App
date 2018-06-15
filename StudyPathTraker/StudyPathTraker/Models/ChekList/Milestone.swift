//
//  Milestone.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/4/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import Realm
import RealmSwift

class Milestone: Object {
    @objc dynamic var name: String?
    @objc dynamic var isDone: Bool = false
    @objc dynamic var uid: String = ""

    required init() {
        super.init()
    }

    convenience init(uid: String, isDone: Bool, name: String) {
        self.init()
        self.uid = uid
        self.isDone = isDone
        self.name = name
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
