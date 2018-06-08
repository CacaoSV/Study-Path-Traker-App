//
//  PersistenceServiceProtocols.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/7/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import RealmSwift

protocol PersistenceStore: class {
    func store<T: Object>(item: T) -> Result<Void>
}

protocol PersistenceRead {
    func getAll<T: Object>(_ type: T.Type) -> Result<[T]>
    func get<T: Object>(_ type: T.Type, with predicate: NSPredicate?) -> Result<[T]>
    func getItem<T: Object>(_ type: T.Type, with primaryKey: String) -> Result<T>
}

protocol PersistenceUpdate {

    // MARK: - Update a single item

    func updateItem(_ update: (() -> Void)) -> Result<Void>
}

protocol PersistenceDelete {

    // MARK: - Delete a single item

    func delete<T: Object>(item type: T) -> Result<Void>
}

protocol PersistenceDeleteAll {

    // MARK: - Delete all items

    func deleteAll() -> Result<Void>
}
