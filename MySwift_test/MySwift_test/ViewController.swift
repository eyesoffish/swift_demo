//
//  ViewController.swift
//  MySwift_test
//
//  Created by fengei on 16/5/20.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    
    var submintButton:UIButton!
    var nameLabel:UILabel!
    var passwordLabel:UILabel!
    var userText:UITextField!
    var passwordText:UITextField!
    var loginDateText:UITextField!
    var loginDatePicker:UIDatePicker!
    var backImage:UIImageView!
    var tableView:UITableView!
    var items:NSMutableArray?
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel = UILabel()
        nameLabel.frame = CGRectMake(0, 20, 100, 30)
        nameLabel.text = "用户名"
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.textColor = UIColor.greenColor()
        
        userText = UITextField()
        userText.frame = CGRectMake(110, 20, 100, 30)
        userText.text = "用户名"
        userText.textAlignment = NSTextAlignment.Center
        userText.textColor = UIColor.grayColor()
        userText.borderStyle = UITextBorderStyle.Bezel
        
        passwordLabel = UILabel()
        passwordLabel.frame = CGRectMake(0, 60, 100, 30)
        passwordLabel.text = "密码"
        passwordLabel.textAlignment = NSTextAlignment.Center
        passwordLabel.textColor = UIColor.greenColor()
        
        passwordText = UITextField()
        passwordText.frame = CGRectMake(110, 60, 100, 30)
        passwordText.text = "密码"
        passwordText.textColor = UIColor.grayColor()
        passwordText.textAlignment = NSTextAlignment.Center
        passwordText.borderStyle = UITextBorderStyle.Line//加边框
        passwordText.secureTextEntry = true
        
        loginDatePicker = UIDatePicker()
        loginDatePicker.datePickerMode = UIDatePickerMode.Date
        loginDatePicker.locale = NSLocale(localeIdentifier:"zh_CH")
        
        loginDateText = UITextField()
        loginDateText.frame = CGRectMake(0, 100, 100, 30)
        loginDateText.text = loginDatePicker.date.description
        loginDateText.textAlignment = NSTextAlignment.Center
        
        loginDateText.inputView = loginDatePicker
        
        backImage = UIImageView(frame:self.view.bounds)
        backImage.image = UIImage(named: "bg1.png")
        
        submintButton = UIButton()
        submintButton.frame = CGRectMake(0, 140, 200, 30)
        submintButton.backgroundColor = UIColor.redColor()
        submintButton.setTitle("登录", forState: UIControlState.Normal)
        submintButton.addTarget(self, action: #selector(ViewController.submintInfo(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        
        tableView = UITableView()
        tableView.frame = CGRectMake(0, 200, 400, 400)
        tableView.dataSource = self
        
        self.items = NSMutableArray()
        self.items?.addObject("abc")
        self.items?.addObject("hhhh")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(backImage)
        self.view.addSubview(loginDateText)
        self.view.addSubview(passwordText)
        self.view.addSubview(passwordLabel)
        self.view.addSubview(userText)
        self.view.addSubview(nameLabel)
        self.view.addSubview(submintButton)
        self.view.addSubview(tableView)
    }
    func submintInfo(button:UIView)
    {
        let scrollView = MyImageScroll()
        scrollView.distance = 2.0
        scrollView.array = ["bg1.jpg","bg2.jpg","bg3.jpg"]
        scrollView.frame = CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 150)
        scrollView.myinit()
        self.view.addSubview(scrollView)
    }
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "foot"
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "header"
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell",forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = self.items?.objectAtIndex(indexPath.row).stringValue
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items!.count
    }
}

