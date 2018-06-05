//
//  SPDetailViewController.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/1/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import UIKit
import WebKit

class SPDetailViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var totalProgressView: UIProgressView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!

    // MARK: - Properties

    var item: Item?

    // MARK: - View Configuration

    override func viewDidLoad() {
        super.viewDidLoad()
        title = item?.name 
        configureView()
        configureWebView()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let checkListViewController = segue.destination  as? SPCheckListViewController {
            checkListViewController.item = item
        }
    }

    // MARK: - Functions

    func configureView() {
        totalProgressView.progress = item?.progress ?? 0.0
    }

    func configureWebView() {
        webView.navigationDelegate = self
        activityIndicatorView.startAnimating()
        if let url = URL(string: item?.url ?? "") {
            webView.load(URLRequest(url: url))
        }
    }

    @IBAction private func addNewCheckListItem(_ sender: Any) {
        performSegue(withIdentifier: Segues.DetailSegues.showCheckList.rawValue, sender: nil)
    }

    func removeActivityIndicator() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
}
