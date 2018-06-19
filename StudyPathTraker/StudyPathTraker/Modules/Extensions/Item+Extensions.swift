//
//  Item+Extensions.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/19/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import Foundation

extension Item {
   static func newItem(name: String, url: String) -> Item {
        return Item(uid: NSUUID().uuidString,
                    name: name, progress: 0.0,
                    url: url,
                    milestones: [Milestone]()
        )
    }
}
