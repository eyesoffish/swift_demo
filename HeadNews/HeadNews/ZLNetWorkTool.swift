//
//  ZLNetWorkTool.swift
//  HeadNews
//
//  Created by fengei on 16/8/30.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON
import MJRefresh

class ZLNetWorkTool: NSObject {
    //单列
    static let shareNetWorkTool = ZLNetWorkTool()
    private override init() {
        super.init()
    }
    
    // 有多少条文章更新
    func loadArticleRefreshTip(finished:(count:Int)->())
    {
        let url = BASE_URL + "2/article/v39/refresh_tip/"
        Alamofire.request(.GET, url).responseJSON { (response) in
            guard response.result.isSuccess else
            {
                SVProgressHUD.showErrorWithStatus("加载失败")
                return
            }
            if let value = response.result.value
            {
                let json = JSON(value)
                let data = json["data"].dictionary
                let count = data!["count"]!.int
                finished(count: count!)
            }
        }
    }
    // 获取首页顶部标题内容
    func loadHomeTitlesData(finished:(topTitles:[ZLHomeTopTitle])->()){
        let url = BASE_URL + "article/category/get_subscribed/v1/?"
        let params = ["device_id":device_id,"aid":13,"iid":IID]
        Alamofire.request(.GET, url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else
            {
                SVProgressHUD.showErrorWithStatus("加载数据失败")
                return
            }
            if let value = response.result.value
            {
                let json = JSON(value)
                let dataDict = json["data"].dictionary
                if let data = dataDict!["data"]!.arrayObject
                {
                    var topics = [ZLHomeTopTitle]()
                    for dic in data
                    {
                        let title = ZLHomeTopTitle(dict: dic as! [String:AnyObject])
                        topics.append(title)
                    }
                    finished(topTitles: topics)
                }
            }
        }
    }
    
    //获取首页不同分类的新闻内容（）
    func loadHomeCategoryNewsFeed(category:String,tableView:UITableView,finished:(nowTime:NSTimeInterval,newsTopidc:[ZLNewsTopic])->()){
        let url = BASE_URL + "api/news/feed/v39/?"
        let params = ["device_id":device_id,"category":category,"iid":IID]
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            let newTime  = NSDate().timeIntervalSince1970
            Alamofire
                .request(.GET, url,parameters: params as? [String : AnyObject])
                .responseJSON{(response) in
                    
                    tableView.mj_header.endRefreshing()
                    guard response.result.isSuccess else{
                        SVProgressHUD.showErrorWithStatus("加载失败")
                        return
                    }
                    if let value = response.result.value{
                        let json = JSON(value)
                        let datas = json["data"].array
                        var topics = [ZLNewsTopic]()
                        for data in datas!{
                            let content = data["content"].stringValue
                            let contentData:NSData = content.dataUsingEncoding(NSUTF8StringEncoding)!
                            do {
                                let dict = try NSJSONSerialization.JSONObjectWithData(contentData, options: .AllowFragments) as! NSDictionary
                                print("dic = ",dict)
                                let topic = ZLNewsTopic(dict: dict as! [String : AnyObject])
                                topics.append(topic)
                            }catch{
                                SVProgressHUD.showErrorWithStatus("获取数据失败")
                            }
                        }
                        finished(nowTime: newTime, newsTopidc: topics)
                    }
            }
        })
        tableView.mj_header.automaticallyChangeAlpha = true//根据拖拽自动切换头
        tableView.mj_header.beginRefreshing()
    }
    
    //获取首页不同分类的新闻内容
    func loadHomeCategoryMoreNewsFeed(category:String,lastRefreshTime:NSTimeInterval,tableView:UITableView,finished:(moreTopics:[ZLNewsTopic])->()){
        
        let url = BASE_URL + "api/news/feed/v39/?"
        let params = ["device_id":device_id,"category":category,"iid":IID,"last_refresh_sub_entrance_interval":lastRefreshTime]
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            Alamofire
                .request(.GET, url,parameters: params as? [String:AnyObject])
                .responseJSON{ (response) in
                    tableView.mj_footer.endRefreshing()
                    guard response.result.isSuccess else{
                        SVProgressHUD.showErrorWithStatus("加载失败")
                        return
                    }
                    if let value = response.result.value{
                        let json = JSON(value)
                        let datas = json["data"].array
                        var topics = [ZLNewsTopic]()
                        for data in datas!{
                            let content = data["content"].stringValue
                            let contentData:NSData = content.dataUsingEncoding(NSUTF8StringEncoding)!
                            do {
                                let dict = try NSJSONSerialization.JSONObjectWithData(contentData, options: .AllowFragments) as! NSDictionary
                                print("more dic = ",dict)
                                let topic = ZLNewsTopic(dict: dict as! [String:AnyObject])
                                topics.append(topic)
                            }catch{
                                SVProgressHUD.showErrorWithStatus("获取数据失败")
                            }
                        }
                        finished(moreTopics: topics)
                    }
            }
        })
    }
}
