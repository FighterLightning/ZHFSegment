//
//  MainTwoVC.swift
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
//"没有导航栏，有tabBar"
class MainTwoVC: ZHFSegmentVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ZHFColor.white
        self.titleScrollViewH = 50 //默认是44 这个属性的位置不能和isHave_Navgation颠倒
        self.isHave_Navgation = false//如果没有导航栏记得设置这个属性（默认是有的）
        self.isHave_Tabbar = true//如果有tabBar记得设置这个属性（默认是没有的）
        
        
        //<--以下内容和MainOneVC完全一样-->
        self.btnW = 105 //默认是100
        self.selectId = 1  //选中位置  默认是0
        self.titleScale = 1.2 //字体缩放倍数，默认是1.3, 设置成1不缩放
        self.titleColor = ZHFColor.black
        self.titleSelectedColor = ZHFColor.red
        //默认是可以通过手势左右滚动 防止子控制器里有ScroolView造成手势冲突，改成false将不能滚动
        self.isScroll = true
        //添加子控制器
        setupAllChildViewController()
        //设置title
        setupAllTitle()
        
        /*<------------下面部分根据项目需求添加------------->*/
        
        //设置titleBtn下划线 （如果没有注释掉即可）
        setTitleBtnBottomLine()
        //设置titleView下划线 （如果没有注释掉即可）
        setTitleViewBottomLine()
        //设置角标 （如果没有注释掉即可)
        //根据子控制器个数设置角标(设置角标一定要在设置title之后，0表示没有，1表示有)默认没有
        refreshTwoAngle()
        setAngle()
    }
    override func viewWillAppear(_ animated: Bool) {
        //这个通知用来刷新角标
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshTwoAngle), name: NSNotification.Name(rawValue: refreshMainTwoAngle), object: nil)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    func setupAllChildViewController(){
        for i in 0 ..< 8 {
            //添加子控制器
            let mainTwoChildVC: MainTwoChildVC = MainTwoChildVC()
            mainTwoChildVC.title = "标题\(i)"
            mainTwoChildVC.titleHeight = self.titleScrollViewH
            mainTwoChildVC.view.backgroundColor = ZHFColor.zhf_randomColor() //为了区分控制器
            addChild(mainTwoChildVC)
        }
    }
    @objc func refreshTwoAngle(){
        //一般情况是网络请求
        //更改角标数组更改角标 为了更直观表达我这里使角标刷新不规律
        let pointMarr = NSMutableArray.init()
        for _ in 0 ..< 8 {
            pointMarr.add(Int(arc4random_uniform(2)))
        }
        self.pointArr = pointMarr as! [Int]
    }
}
