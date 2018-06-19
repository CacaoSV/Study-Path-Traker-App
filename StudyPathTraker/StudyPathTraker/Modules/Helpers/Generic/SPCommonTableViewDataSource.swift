//
//  SPCommonTableViewDataSource.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 5/31/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import Foundation
import UIKit

class SPCommonTableViewDataSource<T, C: UITableViewCell>: NSObject, UITableViewDataSource {
    typealias CellConfiguration = ((C, T, IndexPath) -> Void)
    typealias CellDeleted = ((IndexPath) -> Void)

    var data: [T]
    let reuseIdentifier: String
    let configurationBlock: CellConfiguration
    let deleteBlock: CellDeleted
    var deleteAllowed: Bool

    init(data: [T], reuseIdentifier: String, deleteAllowed: Bool, deleteBlock: @escaping CellDeleted, configurationBlock: @escaping CellConfiguration) {
        self.data = data
        self.reuseIdentifier = reuseIdentifier
        self.configurationBlock = configurationBlock
        self.deleteBlock = deleteBlock
        self.deleteAllowed = deleteAllowed
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? C else {
            return UITableViewCell()
        }

        let item = data[indexPath.row]
        configurationBlock(cell, item, indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteBlock(indexPath)
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return deleteAllowed
    }
}
