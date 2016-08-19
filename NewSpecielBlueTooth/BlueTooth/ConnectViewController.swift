//
//  ConnectViewController.swift
//  BlueTooth
//
//  Created by fengei on 16/5/26.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit
class ConnectViewController: UIViewController , colorServiceManagerDelegate{

    @IBOutlet weak var labelName: UILabel!
    let colorService = ColorManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        colorService.delegate = self
    }
    
    @IBAction func ChangeColorClick(sender: AnyObject) {
        self.changeColor(UIColor.blueColor())
        colorService.sendColor("blue")
    }
    
    func changeColor(color:UIColor)
    {
        UIView.animateWithDuration(0.2) { 
            self.view.backgroundColor = color
        }
    }
    func connectedDevicesChanged(manager: ColorManager, connectedDevies: [String]) {
        self.labelName.text = "\(connectedDevies)"
    }
    func colorChanged(manager: ColorManager, colorString: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock { 
            self.changeColor(UIColor.blueColor())
        }
    }
}
