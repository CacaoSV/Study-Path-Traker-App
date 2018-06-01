//
//  SPItemsTableViewDelegate.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 5/31/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import Foundation
import UIKit

class SPItemsTableViewDelegate: NSObject, UITableViewDelegate {

    public var selectedIndex: ((_ index: Int) -> Void)?

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex?(indexPath.row)
    }
}
