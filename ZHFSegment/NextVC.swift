//
//  NextVC.swift
//  ZHFSegment
//
//  Created by 张海峰 on 2018/11/26.
//  Copyright © 2018年 张海峰. All rights reserved.
//

import UIKit

class NextVC: UIViewController {
    //为了防止从隐藏导航的控制器进来隐藏导航栏
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ZHFColor.white
    }

}
