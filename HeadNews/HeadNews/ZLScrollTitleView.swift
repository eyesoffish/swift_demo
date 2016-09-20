//
//  ZLScrollTitleView.swift
//  HeadNews
//
//  Created by fengei on 16/8/30.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit
import Kingfisher

class ZLScrollTitleView: UIView {

    //存放标题的模型的数组
    var titles = [ZLHomeTopTitle]()
    //存放标题数组
    var labels = [ZLTitleLabel]()
    //存放label的宽度
    private var labelWidths = [CGFloat]()
    //顶部导航拦有变加号按钮点击
    var addBtnClickClosure:(()->())?
    //点击了一个label
    var didSelectTitleLabel:((titlelabel:ZLTitleLabel)->())?
    // 向外界传递titles数组
    var titlesClosure:((titleArray:[ZLHomeTopTitle])->())?
    //记录当前选中的下标
    private var currentIndex = 0
    //记录上一个下标
    private var oldIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //获取首页顶部标题
        ZLNetWorkTool.shareNetWorkTool.loadHomeTitlesData { (topTitles) in
            //添加推荐标题
            let dict = ["category":"__all__","name":"推荐"]
            let recommend = ZLHomeTopTitle(dict: dict)
            self.titles.append(recommend)
            self.titles += topTitles
            self.setupUI()
        }
    }
    
    func setupUI()
    {
        //添加滚动视图
        addSubview(scrollView)
        //添加按钮
        addSubview(addButton)
        // 布局
        scrollView.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.right.equalTo(addButton.snp_left)
        }
        addButton.snp_makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.width.equalTo(30)
        }
        // 添加label
        setupTitleslabel()
        //设置label的位置
        setupLabelPosition()
        //保存titles的数组
        titlesClosure?(titleArray:titles)
    }
    func didSelectTitleLabelClosure(closure:(titleLabel:ZLTitleLabel)->())
    {
        didSelectTitleLabel = closure
    }
    func titleArrayClosure(closure:(titleArray:[ZLHomeTopTitle])->())
    {
        titlesClosure = closure
    }
    private lazy var addButton:UIButton = {
        let addButton = UIButton()
        addButton.setImage(UIImage(named:"add_channel_titlbar_16x16_"), forState: .Normal)
        addButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        addButton.addTarget(self, action: #selector(addButtonClick), forControlEvents: .TouchUpInside)
        return addButton
    }()
    
    //滚动视图
    private lazy var scrollView:UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        return scrollview
    }()
    //右边按钮点击事件
    func addButtonClick()
    {
        addBtnClickClosure?()
    }
    //
    func addButtonClickClosure(closure:()->())
    {
        addBtnClickClosure = closure
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class ZLTitleLabel: UILabel {
    //用来记录当前label的缩放比列
    var currentScale:CGFloat = 1.0 {
        didSet{
            transform = CGAffineTransformMakeScale(currentScale, currentScale)
        }
    }
}
extension ZLScrollTitleView
{
    //添加label
    private func setupTitleslabel()
    {
        for (index ,topic) in titles.enumerate()
        {
            let label = ZLTitleLabel()
            label.text = topic.name
            label.tag = index
            label.textColor = ZLColor(235, g: 235, b: 235, a: 1.0)
            label.textAlignment = .Center
            label.userInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(labelOnClick(_:)))
            label.addGestureRecognizer(tap)
            label.font = UIFont.systemFontOfSize(17)
            label.sizeToFit()
            label.width += kMargin
            labels.append(label)
            labelWidths.append(label.width)
            scrollView.addSubview(label)
        }
        let currentLabel = labels[currentIndex]
        currentLabel.textColor = UIColor.whiteColor()
        currentLabel.currentScale = 1.1
    }
    func setupLabelPosition()
    {
        var titleX:CGFloat = 0.0
        let titleY:CGFloat = 0.0
        var titleW:CGFloat = 0.0
        let titleH = self.height
        
        for (index,label) in labels.enumerate()
        {
            titleW = labelWidths[index]
            titleX = kMargin
            if index != 0
            {
                let lastLabel = labels[index - 1]
                titleX = CGRectGetMaxX(lastLabel.frame) + kMargin
            }
            label.frame = CGRectMake(titleX, titleY, titleW, titleH)
        }
        if let lastLabel = labels.last
        {
            scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0)
        }
    }
    func labelOnClick(tap:UITapGestureRecognizer)
    {
        guard let currentLabel = tap.view as? ZLTitleLabel else{
            return
        }
        oldIndex = currentIndex
        currentIndex = currentLabel.tag
        let oldLabel = labels[oldIndex]
        oldLabel.textColor = ZLColor(235, g: 235, b: 235, a: 1.0)
        oldLabel.currentScale = 1.0
        currentLabel.textColor = UIColor.whiteColor()
        currentLabel.currentScale = 1.1
        // 改变label的位置
        adjustTitleOffSetToCurrentIndex(currentIndex,oldIndes:oldIndex)
        didSelectTitleLabel?(titlelabel:currentLabel)
    }
    
    func adjustTitleOffSetToCurrentIndex(currentIndex:Int,oldIndes:Int)
    {
        guard oldIndex != currentIndex else
        {
            return
        }
        //重新设置label的状态
        let oldLabel = labels[oldIndex]
        let currentLabel = labels[currentIndex]
        currentLabel.currentScale = 1.1
        currentLabel.textColor = UIColor.whiteColor()
        oldLabel.textColor = ZLColor(235, g: 235, b: 235, a: 1.0)
        oldLabel.currentScale = 1.0
        //当前的偏移量
        var offsetX = currentLabel.centerX - SCREENW * 0.5
        if offsetX < 0
        {
            offsetX = 0
        }
        
        //最大偏移量
        var maxOffsetX = scrollView.contentSize.width - (SCREENW - addButton.width)
        if maxOffsetX < 0
        {
            maxOffsetX = 0
        }
        if offsetX > maxOffsetX
        {
            offsetX = maxOffsetX
        }
        scrollView.setContentOffset(CGPointMake(offsetX, 0), animated: true)
    }
    //重写frame
    override var frame:CGRect
    {
        didSet{
            let newFrame = CGRectMake(0, 0, SCREENW, 44)
            super.frame = newFrame
        }
    }
}
