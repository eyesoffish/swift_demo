//
//  CoolAnimationViewController.swift
//  BlueTooth
//
//  Created by fengei on 16/5/26.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

class CoolAnimationViewController: UIViewController {

    var imageView:UIImageView!
    var fiter = CIFilter(name:"CICircleSplashDistortion")
    var content = CIContext(options:nil)
    var extent:CGRect!
    var scaleFactor:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyAdd()
        // Do any additional setup after loading the view.
    }
    func MyAdd()
    {
        imageView = UIImageView(frame:self.view.frame)
        imageView.image = UIImage(named: "willis.jpg")
        self.view.addSubview(imageView)
        imageView.userInteractionEnabled = true
        let pan = UIPanGestureRecognizer(target: self , action: #selector(CoolAnimationViewController.panGestureClick(_:)))
        self.imageView.addGestureRecognizer(pan)
        
        scaleFactor = UIScreen.mainScreen().scale
        extent = CGRectApplyAffineTransform(UIScreen.mainScreen().bounds,CGAffineTransformMakeScale(scaleFactor, scaleFactor))
        let ciImage = CIImage(image: imageView.image!)
        fiter?.setDefaults()
        fiter?.setValue(ciImage, forKey: kCIInputImageKey)
        imageView.image = UIImage(CGImage: content.createCGImage((fiter?.outputImage)!, fromRect: extent))

    }
    func panGestureClick(sender:UIPanGestureRecognizer)
    {
        let location = sender.locationInView(self.imageView)
        let x = location.x * scaleFactor
        let y = imageView.bounds.height * scaleFactor - location.y*scaleFactor
        fiter?.setValue(CIVector(x: x,y: y), forKey: kCIInputCenterKey)
        imageView.image = UIImage(CGImage: content.createCGImage((fiter?.outputImage)!, fromRect: extent))
    }
}
