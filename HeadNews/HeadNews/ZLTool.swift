//
//  File.swift
//  HeadNews
//
//  Created by fengei on 16/8/30.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

func ZLColor(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor
{
    return UIColor(red: r/255.0,green:g/255.0,blue:b/255.0,alpha:a);
}
//背景灰色
func ZLGlobalColor() -> UIColor
{
    return ZLColor(245, g: 245, b: 245, a: 1.0)
}
//红色背景
func ZLGlobalRedColor() -> UIColor
{
    return ZLColor(245, g: 80, b: 83, a: 1.0)
}
/// 动画时长
let kAnimationDurat = 0.25
/// iid 未登录用户 id，只要安装了今日头条就会生成一个 iid
/// 可以在自己的手机上安装一个今日头条，然后通过 charles 抓取一下这个 iid，
/// 替换成自己的，再进行测试
let IID = 5034850950
let device_id = 6096495334
/// 服务器地址
let BASE_URL = "http://lf.snssdk.com/"
/// 屏幕的宽
let SCREENW = UIScreen.mainScreen().bounds.size.width
/// 屏幕的高
let SCREENH = UIScreen.mainScreen().bounds.size.height
/// 间距
let kMargin: CGFloat = 10.0
/// 首页新闻间距
let kHomeMargin: CGFloat = 15.0