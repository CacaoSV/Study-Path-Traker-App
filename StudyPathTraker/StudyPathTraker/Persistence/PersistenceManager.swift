//
//  PersistenceManager.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/7/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import Foundation
import RealmSwift

enum Result<T> {
    case success(T)
    case failure(Error)

    var error: Error? {
        switch self {
        case .success(_):
            return nil
        case .failure(let error):
            return error
        }
    }
}

enum ItemError: Error {
    case itemNotFound

    var localizedDescription: String {
        switch self {
        case .itemNotFound:
            return "Item could not be found in the Realm."
        }
    }
}

struct PersistenceManager {

    // MARK: - Public Methods

    /// Adds or updates an existing object into the Realm.
    ///
    /// - Parameter item: Object to be added to default Realm. Must inherit from RealmSwift's `Object` class.
    /// - Returns: Whether the process completed successfully or failed.
    static func saveItem<T: Object>(item: T) -> Result<Void> {
        switch getRealm() {
        case .success(let realm):
            do {
                try realm.write {
                    realm.add(item, update: T.primaryKey() != nil)
                }
                return .success(())
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }

    /// Creates a write transaction on the default Realm so any item inheriting from RealmSwift's `Object` class can be updated.
    ///
    /// - Parameter update: Block containing the updates to be perfomed.
    /// - Returns: Whether the process completed successfully or failed.
    static func updateItem(_ update:(() -> Void)) -> Result<Void> {
        switch getRealm() {
        case .success(let realm):
            do {
                try realm.write(update)
                return .success(())
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }

    /// Retrieves the single instance of a given object type with the given primary key from the default Realm.
    /// This method requires that primaryKey() be overridden on the given object class.
    ///
    /// - Parameters:
    ///   - primaryKey: The primary key of the desired object.
    ///   - type: The type of the object to be returned.
    /// - Returns: Whether the process completed successfully or failed. If successfull, requested item is appended to the response.
    static func getItem<T: Object>(primaryKey: String, type: T.Type) -> Result<T> {
        switch getRealm() {
        case .success(let realm):
            guard let item = realm.object(ofType: type, forPrimaryKey: primaryKey) else {
                return .failure(ItemError.itemNotFound)
            }
            return .success(item)
        case .failure(let error):
            return .failure(error)
        }
    }

    /// Returns all objects of the given type stored in the default Realm.
    ///
    /// - Parameter type: The type of the objects to be returned.
    /// - filter: A predicate if you want to filter out the results
    /// - Returns:  Whether the process completed successfully or failed. If successfull, array of items of the requested type is appended to the response.
    static func getAllItems<T: Object>(type: T.Type, filter: NSPredicate?) -> Result<[T]> {
        switch getRealm() {
        case .success(let realm):
            var items: [T] = []
            if let predicate = filter {
                items = Array(realm.objects(type).filter(predicate))
            } else {
                items = Array(realm.objects(type))
            }
            return .success(items)
        case .failure(let error):
            return .failure(error)
        }
    }

    /// Deletes an object from the default Realm. Once the object is deleted it is considered invalidated
    ///
    /// - Parameter item: Object to be deleted.
    /// - Returns: Whether the process completed successfully or failed.
    static func deleteItem<T: Object>(item: T) -> Result<Void> {
        switch getRealm() {
        case .success(let realm):
            do {
                try realm.write {
                    realm.delete(item)
                }
                return .success(())
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }

    /// Deletes all objects from the Realm.
    ///
    /// - Returns: Whether the process completed successfully or failed.
    static func deleteAllItems() -> Result<Void> {
        switch getRealm() {
        case .success(let realm):
            do {
                try realm.write {
                    realm.deleteAll()
                }
                return .success(())
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }

    // MARK: - Private Methods

    static private func getRealm() -> Result<Realm> {
        do {
            let realm: Realm
            if NSClassFromString("XCTest") != nil {
                 realm = try Realm(configuration: Realm.Configuration(inMemoryIdentifier: "MemoryRealm"))
            } else {
                 realm = try Realm()
            }
            return .success(realm)
        } catch {
            print("Failed to initialize Realm. Failed with error: \(error.localizedDescription)")
            return .failure(error)
        }
    }
}
