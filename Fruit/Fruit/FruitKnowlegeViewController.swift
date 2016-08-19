//
//  FruitKnowlegeViewController.swift
//  Fruit
//
//  Created by fengei on 16/6/22.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

class FruitKnowlegeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 133/255.0, green: 107/255.0, blue: 0, alpha: 1)
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
