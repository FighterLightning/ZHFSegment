//
//  ZHFTabBar.swift
//  ZHFSegment
//
//  Created by 张海峰 on 2018/11/26.
//  Copyright © 2018年 张海峰. All rights reserved.
//
/*
 如果觉得帮助欢迎fork，star，如果有好的建议欢迎提出来
 demo链接：https://github.com/FighterLightning/ZHFSegment.git
 使用说明链接简书：https://www.jianshu.com/p/e4b49d606989
 */
import UIKit

class ZHFTabBar: UITabBarController {
    var selectedID: NSInteger = 0{
        didSet{
            self.selectedIndex = selectedID
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.view.backgroundColor = ZHFColor.white
        //设置局部tabBar 颜色
        tabBar.tintColor =  ZHFColor.zhf_selectColor
        tabBar.isTranslucent = false
        //1. 获取json 文件路径
        guard let jsonPath = Bundle.main.path(forResource: "tabbar.json", ofType: nil) else {
            ZHFLog(message: "没有获取到对应的文件路径")
            return
        }
        //2. 读取json文件的内容
        guard let jsonData = NSData.init(contentsOfFile: jsonPath) else {
            ZHFLog(message: "没有获取到json文件的内容")
            return
        }
        //3.将Data转数组
        //如果在调用系统的某个方法时，该方法最后有一个throws，说明该方法会抛出异常，如果一个方法会抛出异常，那么需要对该异常进行处理
        /*在swift 中提供三种处理异常的方式
         方式一：try方式（最不常用的方法） 程序员手动处理
         do{
         try JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers)
         }
         catch
         {
         ZHFLog(message: error)
         }
         方式二 try？方式 （最常用的方法）  系统帮助我们处理异常，如果该方法出现异常返回nil 如果没有返回对应的对象
         guard let AnyObject = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) else
         {
         return
         }
         方式三 try！方式 （不建议，方法比较危险）  直接告诉系统没有异常，注意：如果该方法出现异常，会导致系统崩溃（类似强制解包）
         guard let AnyObject = try！ JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers)
         */
        guard let AnyObject = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) else
        {
            return
        }
        guard let dicArray = AnyObject as? [[String : AnyObject]] else {
            return
        }
        //4.遍历字典获取对应的信息
        for dict in dicArray {
            //4.1获取对应的控制器
            guard let vcName: String = dict["vcName"] as? String else{
                continue
            }
            //4.2获取对应的title
            guard let title: String = dict["title"] as? String else{
                continue
            }
            //4.3获取对应的imagename
            guard let imageName: String = dict["imageName"] as? String else{
                continue
            }
            //4.4 添加
            addChildViewController(childVCName: vcName, title: title, imagename: imageName)
        }
    }
    //swift 支持方法重载，方法名称相同，但是1.参数类型不同2.参数个数不同
    //private 方法私有化，当前文件中可以访问，其它文件不能访问
    private func addChildViewController(childVCName: String,title : String, imagename : String) {
        if childVCName == "MainTwoVC" {
            let mainTwoVC:MainTwoVC = MainTwoVC()
            mainTwoVC.title = title
            mainTwoVC.tabBarItem.image = UIImage.init(named: "fire")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            mainTwoVC.tabBarItem.selectedImage = UIImage.init(named: "fire_highlighted")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            mainTwoVC.tabBarItem.imageInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            mainTwoVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
            let childNav = UINavigationController(rootViewController: mainTwoVC)
            addChild(childNav)
        }
        if childVCName == "HomeVC" {
            let homeVC:HomeVC = HomeVC()
            homeVC.title = title
            homeVC.tabBarItem.image = UIImage.init(named: "home")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            homeVC.tabBarItem.selectedImage = UIImage.init(named: "home_highlighted")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            homeVC.tabBarItem.imageInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            homeVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
            let childNav = UINavigationController(rootViewController: homeVC)
            addChild(childNav)
        }
        if childVCName == "MineVC" {
            let mineVC:MineVC = MineVC()
            mineVC.title = title
            mineVC.tabBarItem.image = UIImage.init(named: "mine")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            mineVC.tabBarItem.selectedImage = UIImage.init(named: "mine_highlighted")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            mineVC.tabBarItem.imageInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            mineVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
            let childNav = UINavigationController(rootViewController: mineVC)
            addChild(childNav)
        }
    }
}
