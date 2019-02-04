//
//  ViewController.swift
//  WebBrowserExecuteJavaScript
//
//  Created by Maxim Kovalko on 1/28/19.
//  Copyright © 2019 Maxim Kovalko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var flatScraper = FlatScraper<Building>(endpoint: .kyiv)
    
    override func viewDidLoad() { flatScraper?.fetchData() }
    
}
