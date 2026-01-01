//
//  WebKitViewController.swift
//  Anyswift
//
//  Created by vvii on 2025/12/26.
//

import Foundation
import WebKit

class WebKitViewController: UIViewController {
    let viewModel: WebViewModel
    
    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var config: WKWebViewConfiguration = {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        return config
    }()
    
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: self.view.bounds, configuration: config)
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: [.old, .new], context: nil)
        if let url = URL(string: viewModel.url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    // Swift 6
    nonisolated override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        nonisolated(unsafe) let change = change
        MainActor.assumeIsolated {
            if keyPath == #keyPath(WKWebView.title) {
                if let value = change?[.newKey] as? String {
                    viewModel.title = value
                }
            }
        }
    }
    
    isolated deinit {
        if isViewLoaded {
            webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.title))
        }
    }
}


