//
//  ChildVC.swift
//  ZHFSegment
//
//  Created by 张海峰 on 2018/11/26.
//  Copyright © 2018年 张海峰. All rights reserved.
//
/*
 如果觉得帮助欢迎fork，star，如果有好的建议欢迎提出来
 demo链接：https://github.com/FighterLightning/ZHFSegment.git
 使用说明链接简书：https://www.jianshu.com/p/7493643fddf6
 */
import UIKit
//"没有导航栏，没有tabBar",
class MainOneChildVC: UIViewController {
    var titleHeight: CGFloat = 44.0 //这个是titleScroolView的高，防止中途修改我这里传过来使用，仅供参考
    var tableView:UITableView!
    lazy var dataMarr:NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataMarr = ["返回",
                         "新控制器",
                          "刷新角标",
        ]
         self.setUI()
    }
    func setUI(){
        /*
         (navH - 44): // 状态栏高度
         titleHeight: titleScroll高度
         */
        let viewHeight = ScreenHeight - (navH - 44) - titleHeight
        //100: tableView距离底部的高度
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: viewHeight - 100), style: UITableView.Style.plain)
        tableView.backgroundColor = ZHFColor.zhff9_backGroundColor
        tableView.separatorColor =  ZHFColor.zhf_strColor(hex: "cccccc")
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 25, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        let label: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: tableView.frame.maxY + 10, width: ScreenWidth, height: 30))
        label.text = "没有导航栏  没有tabBar"
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = ZHFColor.white
        self.view.addSubview(label)
    }
    //记得移除通知
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
extension MainOneChildVC :UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataMarr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier  = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style:.default, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.text = self.dataMarr[indexPath.row] as? String
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell?.textLabel?.textColor = ZHFColor.orange
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = self.dataMarr[indexPath.row] as! String
        if indexPath.row == 0 {
           self.navigationController?.popViewController(animated: true)
        }
        else if indexPath.row == 1 {
            let nextVC :NextVC = NextVC()
            nextVC.title =  message
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else if indexPath.row == 2 {
            //通知刷新角标
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: refreshMainOneAngle), object: nil, userInfo: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
