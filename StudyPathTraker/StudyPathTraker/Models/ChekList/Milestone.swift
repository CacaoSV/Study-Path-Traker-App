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
    @objc var isDone: Bool = false
    @objc var name: String?

    convenience init(isDone: Bool, name: String) {
        self.init()
        self.isDone = isDone
        self.name = name
    }
}
