//
//  ViewController.swift
//  MySwift_table_Test
//
//  Created by fengei on 16/5/20.
//  Copyright © 2016年 fengei. All rights reserved.
//
struct Once
{
    static let identifier = "cell"
    static var isRegister : Bool = false
}
import UIKit

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    var items:NSMutableArray?
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        tableView = UITableView(frame: CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.frame)))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.grayColor()
        self.view.addSubview(tableView)
        loadData()
        tableView.registerClass(MyTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    //tableview delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    func loadData()
    {
        let path:String = NSBundle.mainBundle().pathForResource("cityPlist", ofType: "plist")!
        self.items = NSMutableArray(contentsOfFile: path)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.items!.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dic = self.items![section] as! NSDictionary
        return dic["city"]!.count
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dic:NSDictionary = self.items![section] as! NSDictionary
        return dic["country"] as? String
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView!.dequeueReusableCellWithIdentifier("cell") as! MyTableViewCell
        let dic = self.items![indexPath.section] as! NSDictionary
        let citys = dic["city"] as! NSArray
        let dicCity = citys[indexPath.row] as! NSDictionary
        cell.name = (dicCity["cityName"] as? String)!
        cell.myImage = UIImage(named: dicCity["imgName"] as! String)!
        cell.MyDesc = (dicCity["introduction"] as? String)!
        cell.url = (dicCity["detailUrl"] as? String)!
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MyTableViewCell
        let vc = MyViewController()
        vc.title = cell.name
        vc.url = cell.url
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

