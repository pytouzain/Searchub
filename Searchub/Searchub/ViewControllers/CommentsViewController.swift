//
//  CommentsViewController.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 18/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit
import WebKit

class CommentsViewController: UIViewController {

    var viewModel: CommentsViewModel = CommentsViewModel()
    
    lazy var loadStatusView: LoadStatusView = {
        let view = LoadStatusView(frame: CGRect.zero)
        return view
    }()
    
    lazy var webView: WKWebView = {
        /*
         Load css file located at project root. Edit this file to change web content design
         */
        guard
            let path = Bundle.main.path(forResource: "commentsStyle", ofType: "css"),
            let cssString = try? String(contentsOfFile: path).components(separatedBy: .newlines).joined()
            else {
                return WKWebView()
        }
        
        let source = """
        var style = document.createElement('style');
        style.innerHTML = '\(cssString)';
        document.head.appendChild(style);
        """
        
        let userScript = WKUserScript(
            source: source,
            injectionTime: .atDocumentEnd,
            forMainFrameOnly: true
        )
        
        let userContentController = WKUserContentController()
        userContentController.addUserScript(userScript)
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.backgroundColor = UIColor.clear
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadStatusView.loadStatus = .loading
        viewModel.searchComments(success: {
            self.webView.loadHTMLString(self.viewModel.getCommentsHTMLString(), baseURL: Bundle.main.bundleURL)
        }) {
            self.loadStatusView.loadStatus = .error(message: "An error occured while loading comments", isDismissButtonShown: false)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loadStatusView.frame = view.frame
    }
    
    private func setupUI() {
        view.addSubview(loadStatusView)
        loadStatusView.loadStatus = .initial
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        webView.navigationDelegate = self
        view.addSubview(webView)
    }
}

extension CommentsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadStatusView.loadStatus = .resultsFounded
        
        /*
         Fetch web content height and ajdust UI
         */
        webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
            if let checkedHeight = height as? CGFloat {
                self.webView.frame = self.view.bounds
                self.webView.scrollView.contentSize.height = checkedHeight
            }
        })
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadStatusView.loadStatus = .error(message: "Ooops, something went wrong...", isDismissButtonShown: false)
    }
}

