//
//  ZLHomeTopicController.swift
//  HeadNews
//
//  Created by fengei on 16/9/12.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

let topicSmallCellID = "SmallCell"
let topicMiddleCellID = "MiddleCell"
let topicLargeCellID = "LargeCell"
let topicNoImageCellID = "NoImageCell"
class ZLHomeTopicController: UITableViewController {

    //上一次选中tabar的索引
    var lastSelectedIndex = Int()
    //下啦刷新的时间
    private var pullRefreshTime:NSTimeInterval?
    //记录点击的顶部标题
    var topTitle:ZLHomeTopTitle?
    //存放主题的数组
    private var newstopics = [ZLNewsTopic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //添加上啦刷新和下啦刷新
        setupRefresh()
    }
    
    func setupUI()
    {
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 49, 0)
        //注册cell
        tableView.registerClass(ZLHomeSmallCell.self, forCellReuseIdentifier: topicSmallCellID)
        tableView.registerClass(ZLHomeMiddleCell.self, forCellReuseIdentifier: topicMiddleCellID)
        tableView.registerClass(ZLHomeLareCell.self, forCellReuseIdentifier: topicLargeCellID)
        tableView.registerClass(ZLHomeNoImageCell.self, forCellReuseIdentifier: topicNoImageCellID)
        tableView.estimatedRowHeight = 97
        
    }
    
    func setupRefresh()
    {
        pullRefreshTime = NSDate().timeIntervalSince1970
        //获取首页不同分类的新闻内容
        ZLNetWorkTool.shareNetWorkTool.loadHomeCategoryNewsFeed(topTitle!.category!, tableView: tableView) { [weak self] (nowTime, newsTopidc) in
            self!.pullRefreshTime = nowTime
            self!.newstopics = newsTopidc
            self!.tableView.reloadData()
        }
        //获取跟多新闻内容
        ZLNetWorkTool.shareNetWorkTool.loadHomeCategoryMoreNewsFeed(topTitle!.category!, lastRefreshTime: pullRefreshTime!, tableView: tableView) { (moreTopics) in
            self.newstopics += moreTopics
            self.tableView.reloadData()
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newstopics.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newsTopic = newstopics[indexPath.row]
        
        if newsTopic.image_list.count != 0{
            let cell = tableView.dequeueReusableCellWithIdentifier(topicSmallCellID) as! ZLHomeSmallCell
            cell.newsTopic = newsTopic
            cell.closeBtnClick({ (filterWords) in
                print("你点击了举报按钮")
            })
            return cell
        }else{
            if newsTopic.middle_image?.height != nil{
                if newsTopic.video_detail_info?.video_id != nil || newsTopic.large_image_list.count != 0{
                    let cell = tableView.dequeueReusableCellWithIdentifier(topicLargeCellID) as! ZLHomeLareCell
                    cell.newTopic = newsTopic
                    cell.closeButtonClick({ (filterWord) in
                        print("你又点击了大大的举报按钮")
                    })
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCellWithIdentifier(topicMiddleCellID) as! ZLHomeMiddleCell
                    cell.newsTopic = newsTopic
                    cell.closeButtonClick({ (filterWord) in
                        print("你有点击了中中举报按钮")
                    })
                    return cell
                }
            }
            else{
                let cell = tableView.dequeueReusableCellWithIdentifier(topicNoImageCellID) as! ZLHomeNoImageCell
                cell.newsTopic = newsTopic
                cell.closeBtnClick({ (filterWord) in
                    print("没有图片还点击？")
                })
                return cell
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
