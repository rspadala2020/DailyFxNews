//
//  WebViewController.swift
//  dailyFxNews
//
//  Created by raja padala on 07/11/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webview: WKWebView!
    var finalUrl: URL!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(addTapped))

        webview.navigationDelegate = self
        webview.load(URLRequest(url: finalUrl))
        webview.allowsBackForwardNavigationGestures = true
    }
    
    @objc func addTapped() {
        self.dismiss(animated: true, completion: nil)
    }

}
