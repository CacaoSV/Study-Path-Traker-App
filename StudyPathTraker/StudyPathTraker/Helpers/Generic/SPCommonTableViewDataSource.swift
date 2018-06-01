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

    var data: [T]
    let reuseIdentifier: String
    let configurationBlock: CellConfiguration

    init(data: [T], reuseIdentifier: String, configurationBlock: @escaping CellConfiguration) {
        self.data = data
        self.reuseIdentifier = reuseIdentifier
        self.configurationBlock = configurationBlock
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
}
