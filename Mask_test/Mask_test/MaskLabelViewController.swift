//
//  MaskLabelViewController.swift
//  Mask_test
//
//  Created by fengei on 16/8/13.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

class MaskLabelViewController: UIViewController {

    var backlabel:UILabel!
    var beforeLabel:UILabel!
    
    var maskLayer:CALayer!
    
    var faView:UIView!
    var beView:UIView!
    var maskView:CALayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        createBackLabel()
        createBeforelabel()
        addMask()
        
        //
        addfaView()
        addbeView()
        addMaskView()
    }
    
    func addMaskView()
    {
        maskView = CALayer()
        maskView.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        maskView.cornerRadius = 15
        maskView.backgroundColor = UIColor.blackColor().CGColor
        beView.layer.mask = maskView
    }
    
    func addfaView()
    {
        faView = UIView()
        let arrTitle = ["a","b","c"]
        for i in 0 ..< 3
        {
            let btn = UIButton(type: .Custom)
            btn.frame = CGRect(x: i*60, y: 0, width: 40, height: 30);
            btn.setTitle(arrTitle[i], forState: .Normal)
            btn.addTarget(self, action:#selector(MaskLabelViewController.btnclick(_:)), forControlEvents: .TouchUpInside)
            faView.addSubview(btn)
        }
        self.addMyView(faView, color: UIColor.blueColor())
    }
    
    func addbeView()
    {
        beView = UIView()
        let arrTitle = ["a","b","c"]
        for i in 0 ..< 3
        {
            let btn = UIButton(type: .Custom)
            btn.frame = CGRect(x: i*60, y: 0, width: 40, height: 30);
            btn.setTitle(arrTitle[i], forState: .Normal)
            btn.addTarget(self, action:#selector(MaskLabelViewController.btnclick(_:)), forControlEvents: .TouchUpInside)
            beView.addSubview(btn)
        }
        self.addMyView(beView, color: UIColor.redColor())
    }
    
    func btnclick(sender:UIButton)
    {
        UIView.animateWithDuration(0.5) {
            self.maskView.frame = CGRect(origin: sender.frame.origin, size: sender.frame.size)
        }
        print("click me")
    }
    
    func addMyView(tempivew:UIView,color:UIColor)
    {
        tempivew.frame = CGRect(x: 0, y: 300, width: self.view.frame.size.width, height: 50)
        tempivew.backgroundColor = color
        view.addSubview(tempivew)
    }
    
    func createBackLabel()
    {
        backlabel = UILabel(frame: self.getLabelFrame())
        self.addLabel(backlabel, color: UIColor.redColor())
    }
    
    func createBeforelabel()
    {
        beforeLabel = UILabel(frame: self.getLabelFrame())
        self.addLabel(beforeLabel, color: UIColor.greenColor())
    }
    
    func addLabel(label:UILabel,color:UIColor)
    {
        label.font = UIFont.boldSystemFontOfSize(50)
        label.textColor = color
        label.text = "Hello word"
        label.textAlignment = .Center
        self.view.addSubview(label)
    }
    
    func getLabelFrame() -> CGRect
    {
        return CGRectMake(0, 100, self.view.frame.size.width, 50)
    }
    
    func addMask()
    {
        maskLayer = CALayer()
        maskLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        maskLayer.cornerRadius = 25;
        maskLayer.backgroundColor = UIColor.greenColor().CGColor
        self.beforeLabel.layer.mask = maskLayer
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touche in touches
        {
            CATransaction.setDisableActions(true)
            let movePoint = touche.locationInView(beforeLabel)
            var frame = maskLayer.frame
            frame.origin.x = movePoint.x-frame.size.width/2
            maskLayer.frame = frame
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
