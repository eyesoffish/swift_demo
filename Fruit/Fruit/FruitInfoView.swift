//
//  FruitInfoView.swift
//  Fruit
//
//  Created by fengei on 16/6/24.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

class FruitInfoView: UIView {

    private var backImage:UIImageView!
    private var titlelable:UILabel!
    private var btnClose:UIButton!
    private var scrollView:UIScrollView!
    var text:String?{
        get{
            return "label"
        }
        set{
            let tempString = newValue?.stringByReplacingOccurrencesOfString("None", withString: "")
            settingString(tempString!)
        }
    }
    var image:UIImage?{
        get{
            return backImage.image
        }
        set
        {
            self.backImage.image = newValue
        }
    }
    var title:String?{
        get{
            return titlelable.text
        }
        set
        {
            self.titlelable.text = newValue
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        myAdd()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func myAdd(){
        backImage = UIImageView()
        backImage.frame = self.frame
        addEleffer(backImage, rect: self.frame)
        
        titlelable = UILabel()
        titlelable.frame = BQAdaptationFrame(0, 20, CGRectGetWidth(self.frame), 35)
        titlelable.textAlignment = NSTextAlignment.Center
        titlelable.font = UIFont.systemFontOfSize(30, weight: 5)
    
        btnClose = UIButton(type: UIButtonType.Custom)
        btnClose.setTitle("X", forState: UIControlState.Normal)
        btnClose.titleLabel?.font = UIFont.systemFontOfSize(25, weight: 5)
        btnClose.bounds = BQAdaptationFrame(0, 0, 80, 80)
        btnClose.layer.cornerRadius = BQAdaptationWidth()*40
        btnClose.layer.borderColor = UIColor.grayColor().CGColor
        btnClose.layer.borderWidth = 1
        btnClose.center = BQadaptationCenter(CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)-60))
        btnClose.layer.shadowColor = UIColor.blackColor().CGColor
        btnClose.layer.shadowOffset = CGSizeMake(0, 1)
        btnClose.layer.shadowOpacity = 1
        btnClose.addTarget(self, action: #selector(FruitInfoView.btnclick), forControlEvents: UIControlEvents.TouchUpInside)
        
        scrollView = UIScrollView()
        scrollView.frame = BQAdaptationFrame(10, CGRectGetMaxY(self.titlelable.frame), CGRectGetWidth(self.frame)-20, CGRectGetHeight(self.frame)-180)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        
        self.addSubview(backImage)
        self.addSubview(scrollView)
        self.addSubview(titlelable)
        self.addSubview(btnClose)
    }
    func addEleffer(myView:UIView,rect:CGRect){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = rect
        myView.addSubview(effectView)
        effectView.alpha = 1
    }
    func btnclick()
    {
        self.removeFromSuperview()
    }
    func settingString(string:String){
        let tempString = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let tempArray:Array = (tempString.componentsSeparatedByString("。"))
        var maxY:CGFloat = 0
        var labelMaxY:CGFloat = 0
        let scrollHeight = CGFloat(tempArray.count)
        scrollView.contentSize = BQadaptationSize(0, scrollHeight*60)
        for i in tempArray
        {
            let tempLabel = UILabel()
            tempLabel.frame = BQAdaptationFrame(0, CGRectGetMaxY(self.titlelable.frame)+maxY*60+labelMaxY, CGRectGetWidth(self.frame)-40, 40)
            tempLabel.font = UIFont.systemFontOfSize(20)
            tempLabel.text = i
            tempLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
            tempLabel.numberOfLines=0
            tempLabel.sizeToFit()
            self.scrollView.addSubview(tempLabel)
            maxY = maxY + 1
            labelMaxY = CGRectGetHeight(tempLabel.frame)
        }
    }
}
