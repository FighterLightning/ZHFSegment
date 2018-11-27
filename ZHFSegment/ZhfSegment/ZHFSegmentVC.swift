//
//  ZHFSegmentVC.swift
//  ZHFSegment
//
//  Created by 张海峰 on 2018/11/26.
//  Copyright © 2018年 张海峰. All rights reserved.
/*
 如果觉得帮助欢迎fork，star，如果有好的建议欢迎提出来
 demo链接：https://github.com/FighterLightning/ZHFSegment.git
 使用说明链接简书：https://www.jianshu.com/p/e4b49d606989
 */
import UIKit

class ZHFSegmentVC: UIViewController {
    /*不常修改的*/
    let titleViewBottomLine: UIView = UIView() //titleView的下划线
    let titleBtnBottomLine :UIView = UIView() //titleBtn的下划线
    let titleScrollView :UIScrollView = UIScrollView()
    let contentScrollView :UIScrollView = UIScrollView()
    var radioBtn :UIButton = UIButton() //定义一个承接按钮，用于保证单选
    var count :NSInteger = 0   //子控制器个数
    lazy var titleBtns : NSMutableArray = NSMutableArray()
    lazy var pointViews : NSMutableArray = NSMutableArray()
    /*常修改*/
    var titleScrollViewH :CGFloat = 44 // titleView 的高度
    var btnW :CGFloat = 100 //每个按钮的宽
    var selectId : NSInteger = 0 // 选中的ID （默认第一个）
    var pointArr = [0]{didSet{refreshAngle()}}//确定右上角是否有脚标(0为没有，大于0都有)
    var isScroll: Bool = true //是否可以滚动
    var titleColor = ZHFColor.black //title默认颜色
    var titleSelectedColor = ZHFColor.red //title选中颜色
    var titleScale :CGFloat = 1.3 // title有缩放效果，选中时是没选中的1.3倍
    var isHave_Navgation :Bool = true //是否有导航
    var isHave_Tabbar :Bool = false{didSet{refreshFrame()}}//是否有TabBar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleScrollView.backgroundColor = UIColor.white
        self.view.addSubview(titleScrollView)
        self.view.addSubview(contentScrollView)
        self.refreshFrame()
        //设置代理。目的：监听内容滚动视图 什么时候滚动完成
        contentScrollView.delegate=self;
        //分页
        contentScrollView.isPagingEnabled = true;
        //弹簧
        contentScrollView.bounces = false;
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
}

//MARK:-  设置UI
extension ZHFSegmentVC:UIScrollViewDelegate{
    func setupAllTitle() {
        count = self.children.count;
        let btnH :CGFloat = self.titleScrollView.bounds.size.height
        var btnX :CGFloat = 0
        for i in 0 ..< count {
            let titleBtn :UIButton = UIButton.init(type:UIButton.ButtonType.custom)
            let VC :UIViewController =  self.children[i]
            titleBtn.setTitle(VC.title, for: UIControl.State.normal)
            btnX = CGFloat(i) * btnW
            titleBtn.tag = i
            titleBtn.setTitleColor(titleColor, for: UIControl.State.normal)
            titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            titleBtn.frame = CGRect.init(x: btnX, y: 0, width: btnW, height: btnH)
            titleBtn.addTarget(self, action: #selector(titleBtnClick), for: UIControl.Event.touchUpInside)
            self.titleBtns.add(titleBtn)
            if i == selectId {
                titleBtnClick(titleBtn: titleBtn)
            }
            titleScrollView.addSubview(titleBtn)
            titleScrollView.contentSize = CGSize.init(width: CGFloat(count) * btnW, height: 0)
            titleScrollView.showsHorizontalScrollIndicator = false;
            contentScrollView.contentSize = CGSize.init(width: CGFloat(count) * ScreenWidth, height: 0)
            contentScrollView.showsHorizontalScrollIndicator = false;
            if isScroll == false{
                contentScrollView.isScrollEnabled = false
            }
        }
    }
    //刷新主框架frame
    func refreshFrame() {
        if isHave_Navgation == false {
            //减 44 不是减64 考虑到状态栏的高度为20
            titleScrollView.frame = CGRect.init(x: 0, y: navH - 44, width: ScreenWidth, height: titleScrollViewH)
        }
        else{
            titleScrollView.frame = CGRect.init(x: 0, y: navH, width: ScreenWidth, height: titleScrollViewH)
        }
        let y : CGFloat = titleScrollView.frame.maxY + 1
        if isHave_Tabbar == true {
            contentScrollView.frame = CGRect.init(x: 0, y: y, width: ScreenWidth, height: ScreenHeight - y - 50)
        }
        else{
            contentScrollView.frame = CGRect.init(x: 0, y: y, width: ScreenWidth, height: ScreenHeight - y)
        }
        titleViewBottomLine.frame = CGRect.init(x: 0, y: titleScrollView.frame.maxY, width: ScreenWidth, height: 1)
    }
    //设置按钮下划线
    func setTitleBtnBottomLine(){
        titleBtnBottomLine.backgroundColor = ZHFColor.red
        titleScrollView.addSubview(titleBtnBottomLine)
    }
    //设置titleView下划线
    func setTitleViewBottomLine(){
        titleViewBottomLine.backgroundColor = ZHFColor.zhf_color(withHex: 0xeeeeee)
        self.view.addSubview(titleViewBottomLine)
    }
    //设置角标
    func setAngle(){
        for i in 0 ..< self.titleBtns.count {
            let btn: UIButton = self.titleBtns[i] as! UIButton
           
            if pointArr.count > i{
                let isHavePoint : NSInteger = pointArr[i]
                let titleLenth: CGFloat = CGFloat((btn.titleLabel?.text?.count)! * 12)
                let pointView: UIView = UIView.init(frame: CGRect.init(x: btnW/2 + titleLenth/2  , y: titleScrollViewH/2 - 10, width: 6, height: 6))
                pointView.layer.cornerRadius = 3
                pointView.layer.masksToBounds = true
                if isHavePoint > 0{
                    pointView.backgroundColor = ZHFColor.zhf_selectColor
                }
                else{
                    pointView.backgroundColor = ZHFColor.clear
                }
                btn.addSubview(pointView)
                self.pointViews.add(pointView)
            }
        }
    }
    //刷新角标
    func refreshAngle(){
        for i in 0 ..< self.pointViews.count {
            let pointView:UIView = self.pointViews[i] as! UIView
            if pointArr.count > i{
                let isHavePoint : NSInteger = pointArr[i]
                if isHavePoint > 0{
                    pointView.backgroundColor = ZHFColor.zhf_selectColor
                }
                else{
                    pointView.backgroundColor = ZHFColor.clear
                }
                self.pointViews.replaceObject(at: i, with: pointView)
            }
        }
    }
}
//MARK:-  处理关联事件
extension ZHFSegmentVC{
    @objc func titleBtnClick(titleBtn: UIButton)  {
        setupOneViewController(btnTag :titleBtn.tag)
        selButton(btn: titleBtn)
        let x :CGFloat  = CGFloat(titleBtn.tag) * ScreenWidth;
        self.contentScrollView.contentOffset = CGPoint.init(x: x, y: 0);
        selectId = radioBtn.tag
    }
    func selButton(btn: UIButton){
        radioBtn.transform = CGAffineTransform(scaleX: 1, y: 1);
        radioBtn.setTitleColor(titleColor, for: UIControl.State.normal)
        btn.transform = CGAffineTransform(scaleX: titleScale, y: titleScale);
        btn.setTitleColor(titleSelectedColor, for: UIControl.State.normal)
        radioBtn = btn
        selectId = btn.tag
        //移动线
        let x1 :CGFloat = radioBtn.center.x - btnW/3
        titleBtnBottomLine.frame = CGRect.init(x: x1, y: titleScrollViewH - 5, width: btnW*2/3, height: 5)
    }
    func setupOneViewController(btnTag: NSInteger){
        if btnTag < count{
            let VC : UIViewController = self.children[btnTag]
            if (VC.view.superview != nil) {
                return
            }
            let x : CGFloat = CGFloat(btnTag) * ScreenWidth
            VC.view.frame = CGRect.init(x: x, y: 0, width: ScreenWidth, height: contentScrollView.bounds.size.height)
            self.contentScrollView.addSubview(VC.view)
        }
    }
    func setupTitleCenter(btn: UIButton){
        var offsetPoint : CGPoint = titleScrollView.contentOffset
        offsetPoint.x =  btn.center.x -  ScreenWidth / 2
        //左边超出处理
        if offsetPoint.x < 0{
            offsetPoint.x = 0
        }
        let maxX : CGFloat = titleScrollView.contentSize.width - ScreenWidth;
        //右边超出处理
        if offsetPoint.x > maxX {
            offsetPoint.x = maxX
        }
        titleScrollView.setContentOffset(offsetPoint, animated: true)
        radioBtn = btn;
    }
}
//MARK:-  处理UIScrollViewDelegate事件
extension ZHFSegmentVC{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取标题
        let leftI :NSInteger   = NSInteger(scrollView.contentOffset.x / ScreenWidth);
        let rightI :NSInteger   = leftI + 1
        //选中标题
        if (rightI <= titleBtns.count) {
            let titleBtn :UIButton  = titleBtns[leftI] as! UIButton
            setupOneViewController(btnTag: rightI)
            //显示选中控制器的同时也把旁边的也加载出来
            setupOneViewController(btnTag: titleBtn.tag)
            selButton(btn: titleBtn)
            setupTitleCenter(btn: titleBtn)
        }
        //字体缩放 1.缩放比例 2.缩放那两个按钮
        //获取左边的按钮
        let leftBtn :UIButton  = self.titleBtns[leftI] as! UIButton
        //获取右边的按钮
        var rightBtn :UIButton = UIButton()
        if (rightI<self.titleBtns.count) {
            rightBtn  = self.titleBtns[rightI] as! UIButton
        }
        var scaleR :CGFloat  = scrollView.contentOffset.x / ScreenWidth;
        scaleR -=  CGFloat(leftI)
        let scaleL :CGFloat  = 1 - scaleR;
        //缩放按钮
        leftBtn.transform = CGAffineTransform.init(scaleX: scaleL * CGFloat(titleScale - 1) + 1, y: scaleL * CGFloat(titleScale - 1) + 1)
        rightBtn.transform = CGAffineTransform.init(scaleX: scaleR * CGFloat(titleScale - 1) + 1, y: scaleR * CGFloat(titleScale - 1) + 1)
        //颜色渐变
//        let rightColor:UIColor = UIColor.init(red: scaleR, green: 0, blue: 0, alpha: 1)
//        let leftColor:UIColor = UIColor.init(red: scaleL, green: 0, blue: 0, alpha: 1)
        rightBtn.setTitleColor(titleColor, for: UIControl.State.normal)
        leftBtn.setTitleColor(titleSelectedColor, for: UIControl.State.normal)
        //移动线
        let x1 :CGFloat = radioBtn.center.x - btnW/3 + scaleR * btnW
        titleBtnBottomLine.frame = CGRect.init(x: x1, y: titleScrollViewH - 5, width: btnW*2/3, height: 5)
    }
}

