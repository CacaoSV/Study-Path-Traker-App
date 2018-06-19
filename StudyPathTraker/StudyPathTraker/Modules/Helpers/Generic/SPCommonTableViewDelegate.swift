//
//  SPCommonTableViewDelegate.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/4/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import Foundation
import UIKit

class SPCommonTableViewDelegate: NSObject, UITableViewDelegate {

    public var selectedIndex: ((_ index: Int) -> Void)?
    public var deleteSelectedIndex: ((_ index: Int) -> Void)?

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex?(indexPath.row)
    }
}
