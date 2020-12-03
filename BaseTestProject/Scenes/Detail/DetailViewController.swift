//
//  DetailViewController.swift
//  BaseTestProject
//
//  Created by Victor Goncalves Valfre on 30/11/20.
//

import Foundation
import UIKit
import Promises
import SnapKit
import WebKit

protocol DetailViewControllerDelegate: class {
  func goBack()
}

public class DetailViewController: BaseViewController {
    var viewModel: DetailViewModel = DetailViewModel()
    var delegate: DetailViewControllerDelegate?
    var webView: WKWebView?
    var alert = UIAlertController(title: "Alert", message: "Erro ao carregar o site", preferredStyle: .alert)

    public override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView?.allowsBackForwardNavigationGestures = true
        webView?.isUserInteractionEnabled = true
        webView?.navigationDelegate = self

        self.view.backgroundColor = UIColor.Theme.background
        self.view = webView
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.delegate?.goBack()
        }))
        
        // add activity
        //webView?.addSubview(self.loadView)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let url = self.viewModel.url {
            debugPrint("abrindo page: ", url.absoluteURL)
            webView?.load(URLRequest(url: url))
            self.showLoading(true)
        }
    }
}

extension DetailViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.showLoading(false)
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.showLoading(false)
        self.present(alert, animated: true, completion: nil)
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.showLoading(false)
        self.present(alert, animated: true, completion: nil)
    }
}
