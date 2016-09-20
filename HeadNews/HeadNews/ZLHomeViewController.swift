//
//  ZLHomeViewController.swift
//  HeadNews
//
//  Created by fengei on 16/8/30.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

class ZLHomeViewController: UIViewController {
    
    //当前选中的titleLabel的伤一个titleLbabel
    var oldIndex:Int = 0
    //首页顶部标题
    var homeTitles = [ZLHomeTopTitle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //有多少条文章跟心
        showRefreshTipView()
        //处理会标题回调
        TitleViewCallBack()
    }
    private func setupUI()
    {
        view.backgroundColor = ZLGlobalColor()
        automaticallyAdjustsScrollViewInsets = false
        //设置导航栏属性
        navigationController?.navigationBar.barStyle = .Black
        navigationController?.navigationBar.tintColor = ZLColor(210, g: 63, b: 66, a: 1.0)
        //设置titleView
        navigationItem.titleView = titleView
        //添加滚动试图
        view.addSubview(scrollView)
    }
    //有多少文章更新
    private func showRefreshTipView()
    {
        ZLNetWorkTool.shareNetWorkTool.loadArticleRefreshTip { (count) in
            self.tipView.tipLabel.text = (count == 0) ? "暂无更新":"今天更行了\(count)条数据"
            UIView.animateWithDuration(kAnimationDurat, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                    self.tipView.tipLabel.transform = CGAffineTransformMakeScale(1.1, 1.1)
                }, completion: { (_) in
                    self.tipView.tipLabel.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
                    dispatch_after(delayTime, dispatch_get_main_queue(), { 
                        self.tipView.hidden = true
                    })
            })
        }
    }
    private func TitleViewCallBack()
    {
        //返回标题数量
        titleView.titleArrayClosure { (titleArray) in
            self.homeTitles = titleArray
            //归档标题数据
            self.archieveTitles(titleArray)
            for topTitle in titleArray
            {
                let topPicVC = ZLHomeTopicController()
                topPicVC.topTitle = topTitle
                self.addChildViewController(topPicVC)
            }
            self.scrollViewDidEndScrollingAnimation(self.scrollView)
            self.scrollView.contentSize = CGSizeMake(SCREENW*CGFloat(titleArray.count), SCREENH)
        }
    }
    //归档标题数据
    private func archieveTitles(titles:[ZLHomeTopTitle])
    {
        let path:NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        let filePath = path.stringByAppendingPathComponent("top_titles.archive")
        // 归档
        NSKeyedArchiver.archiveRootObject(titles, toFile: filePath)
    }
    private lazy var titleView:ZLScrollTitleView = {
        let titleView = ZLScrollTitleView()
        return titleView
    }()
    private lazy var tipView:ZlTipView = {
        let tipView = ZlTipView()
        tipView.frame = CGRectMake(0, 44, UIScreen.mainScreen().bounds.size.width, 35)
        // 加载再navBar上面，不回随着tableView一起滚动
        self.navigationController?.navigationBar.insertSubview(tipView, atIndex: 0)
        return tipView
    }()
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = UIScreen.mainScreen().bounds
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
}

extension ZLHomeViewController:UIScrollViewDelegate
{
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        //当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        //取出子控制器
        let vc = childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
}
