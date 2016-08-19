//
//  MyImageScroll.swift
//  MySwift_test
//
//  Created by fengei on 16/5/27.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit
class MyImageScroll: UIView,UIScrollViewDelegate{
    
    //用户自己设置间隔时间，和图片。注意，图片格式必须一样
    var array:Array<String>?
    var distance:NSTimeInterval?
    
    
    var pageControl:UIPageControl!
    var scrollView:UIScrollView!
    var timer:NSTimer?
    func myinit()
    {
        self.array?.insert(self.array![self.array!.count-1], atIndex: 0)
        self.array?.insert(self.array![1], atIndex: self.array!.count)
        scrollSetting()//设置
        var i = CGFloat()
        for name in array!
        {
            let imageView = UIImageView(image: UIImage(named: name))
            imageView.frame = CGRectMake(i*CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))
            i = i+1
            self.scrollView.addSubview(imageView)
        }
    }
    private func scrollSetting()
    {
        self.scrollView = UIScrollView(frame:self.bounds)
        self.scrollView.pagingEnabled = true//设置整页翻页
        self.scrollView.showsHorizontalScrollIndicator = false//hide scroll
        self.scrollView.delegate = self
        self.scrollView.bounces = false
        self.scrollView.contentSize = CGSizeMake(CGFloat(self.array!.count)*CGRectGetWidth(self.frame), 0)//设置总偏移量
        
        self.pageControl = UIPageControl(frame: CGRectMake(CGRectGetWidth(self.frame)/2-50,CGRectGetMinY(self.frame)-90,100,40))
        pageControl.numberOfPages = self.array!.count - 2
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.currentPageIndicatorTintColor = UIColor.grayColor()
        self.addSubview(self.scrollView)
        self.addSubview(self.pageControl)
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.frame), 0)
    }
    
    //滚动回调的方法
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame)+0.5)-1
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNum = Int(scrollView.contentOffset.x/CGRectGetWidth(self.scrollView.frame)+0.5-1)
        if pageNum > self.array!.count-3
        {
            scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0)
        }
        if pageNum < 1
        {
            scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame)*CGFloat(self.array!.count-2), 0)
        }
    }
    //自动轮播图片
    func startTimer()
    {
        timer = NSTimer(timeInterval: distance!, target: self, selector: #selector(MyImageScroll.timerChangeImage), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSDefaultRunLoopMode)
    }
    func stopTimer()
    {
        timer?.invalidate()
        timer = nil
    }
    func timerChangeImage()
    {
        let point = CGPointMake(self.scrollView.contentOffset.x+CGRectGetWidth(self.scrollView.frame),0)
        self.scrollView.setContentOffset(point, animated: true)
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopTimer()
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        //滚动完毕调用的方法，去设置pageControl的页码
        scrollViewDidEndDecelerating(scrollView)
    }
}
