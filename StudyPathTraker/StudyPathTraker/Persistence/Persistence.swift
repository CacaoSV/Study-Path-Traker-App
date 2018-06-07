//
//  Persistence.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/6/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import RealmSwift

class Persistence: NSObject, PersistenceStore, PersistenceRead {

    // MARK: - Create
    func store<T: Object>(item: T) -> Result<Void> {
        return PersistenceManager.saveItem(item: item)
    }

    // MARK: - Read
    func getAll<T: Object>(_ type: T.Type) -> Result<[T]> {
        return PersistenceManager.getAllItems(type: type, filter: nil)
    }

    // MARK: - Get result of items
    func get<T: Object>(_ type: T.Type, with predicate: NSPredicate?) -> Result<[T]> {
        return PersistenceManager.getAllItems(type: type, filter: predicate)
    }

    // MARK: - Get a single item
    func getItem<T: Object>(_ type: T.Type, with primaryKey: String) -> Result<T> {
        return PersistenceManager.getItem(primaryKey: primaryKey, type: type)
    }
}
