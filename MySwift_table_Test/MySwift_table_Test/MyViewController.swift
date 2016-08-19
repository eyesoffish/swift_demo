//
//  MyViewController.swift
//  MySwift_table_Test
//
//  Created by fengei on 16/5/21.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    var url:String?
    var webView:UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MyAdd()
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url!)!))
    }
    func MyAdd(){
        webView = UIWebView()
        webView.frame = self.view.bounds
        self.view.addSubview(webView)
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
