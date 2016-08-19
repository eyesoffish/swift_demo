//
//  ModelInfo.swift
//  MyAPP_PMSeach
//
//  Created by fengei on 16/5/25.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

class ModelInfo: NSObject {
    var AQI:String?;
    var AQIinfo:String? = "AQI指数";//AQI指数
    
    var pm:String?;
    var pmInfo:String? = "首要污染物";//首要污染物
    
    var pm25:String?;
    var pm25Info:String? = "PM2.5浓度";//pm2.5浓度
    init(aqi:String,pm:String,pm25:String)
    {
        self.AQI = aqi
        self.pm = pm
        self.pm25 = pm25
    }
}
