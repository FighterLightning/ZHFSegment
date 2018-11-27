//
//  HomeVC.swift
//  ZHFSegment
//
//  Created by 张海峰 on 2018/11/26.
//  Copyright © 2018年 张海峰. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
