//
//  Item.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 5/31/18.
//  Copyright © 2018 Jerti. All rights reserved.
//
import RealmSwift
import Realm

class Item: Object {
    @objc dynamic var name: String?
    @objc dynamic var progress: Float = 0.0
    @objc dynamic var url: String?
    @objc dynamic var uid: String = ""
    var milestones = List<Milestone>()

    required init() {
        super.init()
    }

    convenience init(uid: String, name: String, progress: Float, url: String, milestones: [Milestone]) {
        self.init()
        self.uid = uid
        self.name = name
        self.progress = progress
        self.url = url
        self.milestones.append(objectsIn: milestones)
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
