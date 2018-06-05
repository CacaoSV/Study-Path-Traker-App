//
//  SPDetailWebViewDelegate.swift
//  StudyPathTraker
//
//  Created by Rafael Lopez on 6/1/18.
//  Copyright © 2018 Jerti. All rights reserved.
//

import WebKit

extension SPDetailViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation) {
        removeActivityIndicator()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation, withError error: Error) {
        removeActivityIndicator()
    }
}
