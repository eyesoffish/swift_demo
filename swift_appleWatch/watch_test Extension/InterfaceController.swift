//
//  InterfaceController.swift
//  watch_test Extension
//
//  Created by fengei on 16/8/24.
//  Copyright © 2016年 fengei. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var image: WKInterfaceImage!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    func delay(delay:Double,closure:()->())
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
    @IBAction func btnClick() {
        //动画
        image.setImageNamed("action")
        image.startAnimatingWithImagesInRange(NSRange(location: 0,length: 3), duration: 0.3, repeatCount: 3)
        delay(0.4) {
            //设置图片
            let imageName = arc4random_uniform(3)//0-2的随机整数
            self.image.setImageNamed("action\(imageName)")
        }
        
    }

}
