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
    let milestones = List<Milestone>()

    convenience init(name: String, progress: Float, url: String, milestones: [Milestone]) {
        self.init()

        self.name = name
        self.progress = progress
        self.url = url
        self.milestones.append(objectsIn: milestones)
    }
}
