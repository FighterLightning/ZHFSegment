//
//  Common.swift
//  ZHFSegment
//
//  Created by 张海峰 on 2018/11/26.
//  Copyright © 2018年 张海峰. All rights reserved.
//
import Foundation
import UIKit

//设备物理尺寸
let ScreenHeight = UIScreen.main.bounds.size.height
let ScreenWidth = UIScreen.main.bounds.size.width
let isIphoneX: Bool = ScreenHeight == 812 || ScreenHeight == 896 ?true:false
let navH: CGFloat = isIphoneX ? 89.0:64.0  //是否是刘海屏的导航高
let barH: CGFloat = isIphoneX ? 80.0:50.0  //是否是刘海屏的 tabBar 的高
/*通知名称*/
let refreshMainOneAngle = "refreshMainOneAngle" //刷新MainOne角标
let refreshMainTwoAngle = "refreshMainTwoAngle" //刷新MainTwo角标
let refreshMainThreeAngle = "refreshMainThreeAngle" //刷新MainThree角标
let refreshMainFourAngle = "refreshMainFourAngle" //刷新MainFour角标
