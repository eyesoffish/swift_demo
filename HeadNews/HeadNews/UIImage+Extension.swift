//
//  UIImage+Extension.swift
//  HeadNews
//
//  Created by fengei on 16/9/14.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit
import Kingfisher
extension UIImage{
    func circleImage() -> UIImage{
        //false 代表透明
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        //获得上下文
        let ctx = UIGraphicsGetCurrentContext()
        //添加一个圆
        let rect = CGRectMake(0, 0, size.width, size.height)
        CGContextAddEllipseInRect(ctx, rect)
        
        //剪裁
        CGContextClip(ctx)
        // 将图片画上去
        drawInRect(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        return image
    }
}
extension UIImageView{
    func setCircleHeader(url:String){
        let placeholder = UIImage(named: "home_head_default_29x29_")
        self.kf_setImageWithURL(NSURL(string: url)!)
        self.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: placeholder, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
            self.image = (image == nil) ? placeholder : image?.circleImage()
        }
    }
}