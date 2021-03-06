//
//  WebViewController.swift
//  WebViewWithLaunchScreen
//
//  Created by Роман Елфимов on 22.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    //MARK: - Properties
    let urlString: String = "https://ru.wikipedia.org"
    var activityViewController: UIActivityViewController? = nil
    
    //MARK: - Outlets
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var goBackButton: UIBarButtonItem!
    @IBOutlet weak var goForwardButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
    }
    
    //MARK: - Method
     
    //метод включает/выключает индикатор загрузки
    func isWorkingIndicator(isAnimated: Bool, indicator: UIActivityIndicatorView) {
        if isAnimated {
            indicator.startAnimating()
            indicator.isHidden = false
        } else {
            indicator.stopAnimating()
            indicator.isHidden = true
        }
    }
    
    //MARK: - Actions
    
    @IBAction func goBackButtonTapped(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func goForwardButtonTapped(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        activityViewController = UIActivityViewController(activityItems: [webView.url ?? "nil"], applicationActivities: nil)
        present(self.activityViewController!, animated: true, completion: nil)
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        webView.reload()
    }
    
}


//MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    
    // Метод срабатывает во время начала загрузки страницы. Кнопки назад, вперед недоступны
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //включаем индикатор загрузки
        isWorkingIndicator(isAnimated: true, indicator: activityIndicator)
        
        goBackButton.isEnabled = false
        goForwardButton.isEnabled = false
    }
    
    // Метод срабатывает после загрузки страницы
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //выключаем индикатор загрузки
        isWorkingIndicator(isAnimated: false, indicator: activityIndicator)
        // Если возможно - кнопки доступны
        if webView.canGoBack {
            goBackButton.isEnabled = true
        } else if webView.canGoForward {
            goForwardButton.isEnabled = true
        }
    }
}
