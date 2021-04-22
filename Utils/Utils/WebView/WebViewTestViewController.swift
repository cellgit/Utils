//
//  WebViewTestViewController.swift
//  Utils
//
//  Created by liuhongli on 2021/4/21.
//

import UIKit
import WebKit
import SnapKit

class WebViewTestViewController: UIViewController {
    
    lazy var webView: WKWebView = {
        let webView = WKWebView.init()
//        webView.uiDelegate = self
//        webView.navigationDelegate = self
        webView.scrollView.gestureRecognizers?.removeAll()
        return webView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        initialUI()
    }
    

    func initialUI() {
        view.addSubview(webView)
        webView.fillSuperview()
        webView.scrollView.isScrollEnabled = true
        
//        let host = "http://192.168.8.82:8008"
        let host = "http://192.168.8.82:8002"
//        let host = "https://pre-test-zctx.zjyjc.com/pad"
        
        let url = "\(host)/?catalogId=d7c3fb33c41cb052ad14a6948d7d0e83&columnId=26&studentId=7470142c6fb6474c9bfa610591efde38"
        
//        let url = "https://test-zctx.zjyjc.com/pad/?catalogId=d7c3fb33c41cb052ad14a6948d7d0e83&columnId=26&studentId=7470142c6fb6474c9bfa610591efde38"
        
        debugPrint("url =========== \(url)")
        let requestUrl = URL.init(string: url)
        if let requestUrl = requestUrl {
            let request = URLRequest(url: requestUrl)
            webView.load(request)
        }

    }

}
