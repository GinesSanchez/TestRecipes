//
//  WebViewController.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-28.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import UIKit
import WebKit

protocol WebViewControllerDelegate: class {
    func viewDidDisappear(viewController: WebViewController)
}

final class WebViewController: UIViewController {

    //Public Properties
    weak var delegate: WebViewControllerDelegate?
    var url: URL!

    //IBOutlets
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.viewDidDisappear(viewController: self)
    }
}

//MARK: - Set Up Methods
private extension WebViewController {

    func setUp() {
        setUpWebViews()
        setUpNavigationBar()
    }

    func setUpWebViews() {
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }

    func setUpNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
    }
}
