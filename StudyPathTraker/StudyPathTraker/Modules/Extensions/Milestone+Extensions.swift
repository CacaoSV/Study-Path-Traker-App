//
//  Milestone+Extensions.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/19/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import Foundation

extension Milestone {
    static func newMilestone(name: String) -> Milestone {
        return Milestone(uid: NSUUID().uuidString,
                         isDone: false,
                         name: name)
    }
}
