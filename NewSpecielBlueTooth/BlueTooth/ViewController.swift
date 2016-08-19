//
//  ViewController.swift
//  BlueTooth
//
//  Created by fengei on 16/5/26.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit
import Social
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func otherClick(sender: AnyObject) {
        self.presentViewController(CoolAnimationViewController(), animated: true, completion: nil)
    }
    @IBAction func weboClick(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTencentWeibo)
        {
            let webo = SLComposeViewController(forServiceType:SLServiceTypeTencentWeibo)
            self.presentViewController(webo, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "title" ,message: "please login webo",preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK",style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    @IBAction func sinaClick(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeSinaWeibo)
        {
            let sina = SLComposeViewController(forServiceType:SLServiceTypeSinaWeibo)
            self.presentViewController(sina, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "title",message: "please login sina",preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "ok",style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}

