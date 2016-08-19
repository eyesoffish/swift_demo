//
//  MenuButton.swift
//  Fruit
//
//  Created by fengei on 16/6/18.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

protocol MenuButtonDelegate {
    func buttonClick(sender:UIButton)
}
class MenuButton: UIView {

    var delegate:MenuButtonDelegate?
    private var button:UIButton!
    private var backView:UIView!
    var buttonImage:UIImage?{
        get{
            return button.backgroundImageForState(UIControlState.Normal)
        }
        set
        {
            button.setBackgroundImage(newValue!, forState: UIControlState.Normal)
        }
    }
    var buttonTitle:String!{
        get{
            return button.titleLabel?.text
        }
        set
        {
            button.setTitle(newValue!, forState: UIControlState.Normal)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        MyAdd()
    }
    
    func MyAdd()
    {
        let backViewWidth:CGFloat = 125
        backView = UIView()
        backView.frame = CGRect(x: 0, y: 0, width: backViewWidth, height: backViewWidth)
        backView.backgroundColor = UIColor.clearColor()
        backView.layer.cornerRadius = backViewWidth / 2
        backView.layer.borderWidth = 5
        backView.layer.borderColor = UIColor.whiteColor().CGColor
        
        let center = CGRectGetWidth(backView.frame) / 2.0
        
        button = UIButton(type: UIButtonType.Custom);
        button.bounds = CGRectMake(0, 0, 70, 70);
        button.center = CGPointMake(center,center)
        button.contentEdgeInsets = UIEdgeInsetsMake(80, 0, 0, 0)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "default", size: 12)
        button.addTarget(self, action: #selector(MenuButton.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backView.addSubview(button)
        self.addSubview(backView)
    }
    func btnClick(sender:UIButton) {
        if self.delegate != nil {
            delegate?.buttonClick(sender)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
