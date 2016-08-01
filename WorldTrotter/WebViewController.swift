//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Giovanni Catania on 23/04/16.
//  Copyright © 2016 Giovanni Catania. All rights reserved.
//

import UIKit
import WebKit

class WebViewController : UIViewController, WKNavigationDelegate {

    // MARK: - Properties
    
    var webView : WKWebView!
    
    // MARK: - Superclass methods override section
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "https://www.bignerdranch.com")!
        webView.loadRequest(NSURLRequest(URL: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
