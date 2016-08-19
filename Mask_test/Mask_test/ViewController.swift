//
//  ViewController.swift
//  Mask_test
//
//  Created by fengei on 16/8/12.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

let GrayImageName = "jobs_gray"
let ColorImageName = "jobs_color"
let MaskImageName = "mask_image"
class ViewController: UIViewController {

    var maskImage:(UIImage)!
    var imageView:(UIImageView)!
    var grayImageView:(UIImageView)!
    var maskLayer:(CALayer)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //图片萌版
//        addGrayImage()
        addColorImage()
//        addLayer()

    }
    func addGrayImage()
    {
        grayImageView = UIImageView(frame: view.bounds);
        self.addImageView(grayImageView, imageName: GrayImageName)
    }
    func addColorImage()
    {
        imageView = UIImageView(frame: view.bounds)
        self.addImageView(imageView, imageName: ColorImageName)
    }
    func addLayer()
    {
        maskLayer = CALayer()
        maskImage = UIImage(named: MaskImageName)
        maskLayer.frame = CGRect(origin: CGPointZero, size: maskImage.size)
        maskLayer.contents = maskImage.CGImage
        maskLayer.position = view.center
        imageView.layer.mask = maskLayer
    }
    func addImageView(imageView:UIImageView,imageName:String) {
        imageView.contentMode = .ScaleAspectFill
        imageView.image = UIImage(named: imageName)
        self.view.addSubview(imageView)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        for toche in touches
//        {
//            CATransaction.setDisableActions(true)
//            maskLayer.position = toche.locationInView(self.view);
//        }
        let maskControl = MaskLabelViewController()
        self.navigationController!.pushViewController(maskControl, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

