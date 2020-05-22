//
//  ViewController.swift
//  WebViewWithLaunchScreen
//
//  Created by Роман Елфимов on 22.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    //MARK: - Properties
    let timeInterval = 0.8
    var timer: Timer?
    var progress: Float = 0
    
    //MARK: - Outlet
    
    @IBOutlet weak var progressView: UIProgressView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startProgress()
    }

    
    //MARK: - Methods
    
    // Запуск progressView
    private func startProgress() {
        progress += 0.1
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(tic), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    // Селектор для startProgress()
    @objc func tic() {
        progress += 0.1
        progressView.progress = progress
        
        if progress >= 1 {
            timer?.invalidate()
            progressView.progress = 0
            performSegue(withIdentifier: "showWebView", sender: nil)
        }
    }
}

