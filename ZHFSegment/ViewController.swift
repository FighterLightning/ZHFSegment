//
//  ViewController.swift
//  ZHFSegment
//
//  Created by 张海峰 on 2018/11/26.
//  Copyright © 2018年 张海峰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tableView:UITableView!
    lazy var dataMarr:NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ZHFSegment"
        self.addTableView()
        self.dataMarr = ["没有导航栏，没有tabBar",
                        "没有导航栏，有tabBar",
                        "有导航栏，没有tabBar",
                        "有导航栏，有tabBar",
                ]
    }
    //为了防止从隐藏导航的控制器返回隐藏导航栏
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    func addTableView(){
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: UITableView.Style.plain)
        self.view.addSubview(tableView)
        tableView.backgroundColor = ZHFColor.zhff9_backGroundColor
        tableView.separatorColor =  ZHFColor.zhf_strColor(hex: "cccccc")
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 25, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension ViewController :UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataMarr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let segmentCellIdentifier  = "segmentCellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: segmentCellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style:.default, reuseIdentifier: segmentCellIdentifier)
        }
        cell?.textLabel?.text = self.dataMarr[indexPath.row] as? String
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell?.textLabel?.textColor = ZHFColor.zhf_randomColor()
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = self.dataMarr[indexPath.row] as! String
        if indexPath.row == 0 {
            //"没有导航栏，没有tabBar",
            let mainOneVC :MainOneVC = MainOneVC()
            mainOneVC.title =  message
            self.navigationController?.pushViewController(mainOneVC, animated: true)
        }
        else if indexPath.row == 1 {
            // "没有导航栏，有tabBar",
            let zhfTabBar :ZHFTabBar = ZHFTabBar()
            self.present(zhfTabBar, animated: true) {}
        }
        else if indexPath.row == 2 {
            // "有导航栏，没有tabBar",
            let mainThreeVC :MainThreeVC = MainThreeVC()
            mainThreeVC.title =  message
            self.navigationController?.pushViewController(mainThreeVC, animated: true)
        }
        else if indexPath.row == 3 {
            // "有导航栏，有tabBar",
            let zhfOtherTabBar :ZHFOtherTabBar = ZHFOtherTabBar()
            self.present(zhfOtherTabBar, animated: true) {}
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

