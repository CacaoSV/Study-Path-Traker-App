//
//  SPBasePresenterProtocol.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/14/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import Foundation

protocol SPBasePresenterProtocol: class {
    func didSuccessAction(_ message: String)
    func showError(_ message: String)
}
