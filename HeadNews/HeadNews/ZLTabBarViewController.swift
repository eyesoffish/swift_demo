//
//  ZLTabBarViewController.swift
//  HeadNews
//
//  Created by fengei on 16/8/30.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

class ZLTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = ZLColor(111, g: 111, b: 111, a: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addChildViewControllers()
    {
        addChildViewControllers(ZLHomeViewController(), title: "首页", imageName: "home_tabbar_22x22_", selectedImageName: "home_tabbar_press_22x22_")
        addChildViewControllers(ZLVedioViewController(), title: "视频", imageName: "video_tabbar_22x22_", selectedImageName: "video_tabbar_press_22x22_")
        addChildViewControllers(ZLNewCareViewController(), title: "关注", imageName: "newcare_tabbar_22x22_", selectedImageName: "newcare_tabbar_press_22x22_")
        addChildViewControllers(ZLMineViewController(), title: "我的", imageName: "mine_tabbar_22x22_", selectedImageName: "mine_tabbar_press_22x22_")
    }
    func addChildViewControllers(childController:UIViewController,title:String,imageName:String,selectedImageName:String)
    {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        childController.title = title
        let nav = ZLNavigationViewController(rootViewController: childController)
        addChildViewController(nav)
    }
}
