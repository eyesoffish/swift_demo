//
//  ViewController.swift
//  MyAPP_PMSeach
//
//  Created by fengei on 16/5/24.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit
class ViewController: UITableViewController {

    var model:ModelInfo?
    var apiValue:String?
    var pmVlaue:String?
    var pm25Value:String?
    let indexSet = ["A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","W","X","Y","Z"]
    
    let dataSet = [
        ["鞍山","安阳"],
        ["保定","宝鸡","包头","北海","北京","本溪","滨州"],
        ["沧州","长春","常德","长沙","常熟","长治","常州","潮州","承德","成都","赤峰","重庆"],
        ["大连","丹东","大庆","大同","德阳","德州","东莞","东营"],
        ["鄂尔多斯"],
        ["佛山","抚顺","富阳","福州"],
        ["广州","桂林","贵阳"],
        ["哈尔滨","海口","海门","邯郸","杭州","合肥","衡水","河源","菏泽","淮安","呼和浩特","惠州","葫芦岛","湖州"],
        ["江门","江阴","胶南","胶州","焦作","嘉兴","嘉峪关","揭阳","吉林","即墨","济南","金昌","荆州","金华","济宁","金坛","锦州","九江","句容"],
        ["开封","克拉玛依","库尔勒","昆明","昆山"],
        ["莱芜","莱西","莱州","廊坊","兰州","拉萨","连云港","聊城","临安","临汾","临沂","丽水","柳州","溧阳","洛阳","泸州"],
        ["马鞍山","茂名","梅州","绵阳","牡丹江"],
        ["南昌","南充","南京","南宁","南通","宁波"],
        ["盘锦","攀枝花","蓬莱","平顶山","平度"],
        ["青岛","清远","秦皇岛","齐齐哈尔","泉州","曲靖","衢州"],
        ["日照","荣成","乳山"],
        ["三门峡","三亚","上海","汕头","汕尾","韶关","绍兴","沈阳","深圳","石家庄","石嘴山","寿光","宿迁","苏州"],
        ["泰安","太仓","太原","台州","泰州","唐山","天津","铜川"],
        ["瓦房店","潍坊","威海","渭南","文登","温州","武汉","芜湖","吴江","乌鲁木齐","无锡"],
        ["厦门","西安","湘潭","咸阳","邢台","西宁","徐州"],
        ["延安","盐城","阳江","阳泉","扬州","烟台","宜宾","宜昌","银川","营口","义乌","宜兴","岳阳","云浮","玉溪"],
        ["枣庄","张家港","张家界","张家口","章丘","湛江","肇庆","招远","郑州","镇江","中山","舟山","珠海","诸暨","株洲","淄博","自贡","遵义"]
    ]
    var urlData = [
        "东莞":"http://www.pm25.com/city/dongguan.html",
        "南宁":"http://www.pm25.com/city/nanncom/cityg.html",
        "胶州":"http://www.pm25.com/city/jiaozhou.html",
        "马鞍山":"http://www.pm25.com/city/maanshan.html",
        "东营":"http://www.pm25.com/city/dongycom/cityg.html",
        "菏泽":"http://www.pm25.com/city/heze.html",
        "秦皇岛":"http://www.pm25.com/city/qcom/cityhuangdao.html",
        "滨州":"http://www.pm25.com/city/bcom/cityzhou.html",
        "海口":"http://www.pm25.com/city/haikou.html",
        "唐山":"http://www.pm25.com/city/tangshan.html",
        "河源":"http://www.pm25.com/city/heyuan.html",
        "临汾":"http://www.pm25.com/city/lcom/cityfen.html",
        "阳泉":"http://www.pm25.com/city/yangquan.html",
        "德州":"http://www.pm25.com/city/dezhou.html",
        "昆明":"http://www.pm25.com/city/kunmcom/cityg.html",
        "胶南":"http://www.pm25.com/city/jiaonan.html",
        "杭州":"http://www.pm25.com/city/hangzhou.html",
        "湖州":"http://www.pm25.com/city/huzhou.html",
        "石嘴山":"http://www.pm25.com/city/shizuishan.html",
        "泉州":"http://www.pm25.com/city/quanzhou.html",
        "铜川":"http://www.pm25.com/city/tongchuan.html",
        "贵阳":"http://www.pm25.com/city/guiyang.html",
        "宜昌":"http://www.pm25.com/city/yichang.html",
        "长沙":"http://www.pm25.com/city/changsha.html",
        "南充":"http://www.pm25.com/city/nanchong.html",
        "金坛":"http://www.pm25.com/city/jcom/citytan.html",
        "渭南":"http://www.pm25.com/city/wecom/cityan.html",
        "南通":"http://www.pm25.com/city/nantong.html",
        "绵阳":"http://www.pm25.com/city/mianyang.html",
        "郑州":"http://www.pm25.com/city/zhengzhou.html",
        "韶关":"http://www.pm25.com/city/shaoguan.html",
        "安阳":"http://www.pm25.com/city/anyang.html",
        "张家界":"http://www.pm25.com/city/zhangjiajie.html",
        "大连":"http://www.pm25.com/city/dalian.html",
        "玉溪":"http://www.pm25.com/city/yuxi.html",
        "富阳":"http://www.pm25.com/city/fuyang.html",
        "盐城":"http://www.pm25.com/city/yancheng.html",
        "海门":"http://www.pm25.com/city/haimen.html",
        "淮安":"http://www.pm25.com/city/huaian.html",
        "潮州":"http://www.pm25.com/city/chaozhou.html",
        "扬州":"http://www.pm25.com/city/yangzhou.html",
        "焦作":"http://www.pm25.com/city/jiaozuo.html",
        "无锡":"http://www.pm25.com/city/wuxi.html",
        "承德":"http://www.pm25.com/city/chengde.html",
        "上海":"http://www.pm25.com/city/shanghai.html",
        "柳州":"http://www.pm25.com/city/liuzhou.html",
        "乌鲁木齐":"http://www.pm25.com/city/wulumuqi.html",
        "威海":"http://www.pm25.com/city/weihai.html",
        "天津":"http://www.pm25.com/city/tianjcom/city.html",
        "宜兴":"http://www.pm25.com/city/yixcom/cityg.html",
        "南昌":"http://www.pm25.com/city/nanchang.html",
        "云浮":"http://www.pm25.com/city/yunfu.html",
        "北京":"http://www.pm25.com/city/beijcom/cityg.html",
        "济南":"http://www.pm25.com/city/jcom/cityan.html",
        "芜湖":"http://www.pm25.com/city/wuhu.html",
        "鄂尔多斯":"http://www.pm25.com/city/eerduosi.html",
        "临沂":"http://www.pm25.com/city/lcom/cityyi.html",
        "宜宾":"http://www.pm25.com/city/yibcom/city.html",
        "荣成":"http://www.pm25.com/city/rongcheng.html",
        "邢台":"http://www.pm25.com/city/xcom/citygtai.html",
        "宝鸡":"http://www.pm25.com/city/baoji.html",
        "文登":"http://www.pm25.com/city/wendeng.html",
        "聊城":"http://www.pm25.com/city/liaocheng.html",
        "金华":"http://www.pm25.com/city/jcom/cityhua.html",
        "鞍山":"http://www.pm25.com/city/anshan.html",
        "赤峰":"http://www.pm25.com/city/chifeng.html",
        "泰安":"http://www.pm25.com/city/taian.html",
        "汕尾":"http://www.pm25.com/city/shanwei.html",
        "丹东":"http://www.pm25.com/city/dandong.html",
        "廊坊":"http://www.pm25.com/city/langfang.html",
        "义乌":"http://www.pm25.com/city/yiwu.html",
        "武汉":"http://www.pm25.com/city/wuhan.html",
        "汕头":"http://www.pm25.com/city/shantou.html",
        "大同":"http://www.pm25.com/city/datong.html",
        "徐州":"http://www.pm25.com/city/xuzhou.html",
        "台州":"http://www.pm25.com/city/taizhou.html",
        "广州":"http://www.pm25.com/city/guangzhou.html",
        "哈尔滨":"http://www.pm25.com/city/haerbcom/city.html",
        "自贡":"http://www.pm25.com/city/zigong.html",
        "淄博":"http://www.pm25.com/city/zibo.html",
        "章丘":"http://www.pm25.com/city/zhangqiu.html",
        "佛山":"http://www.pm25.com/city/foshan.html",
        "西宁":"http://www.pm25.com/city/xcom/citycom/cityg.html",
        "克拉玛依":"http://www.pm25.com/city/kelamayi.html",
        "枣庄":"http://www.pm25.com/city/zaozhuang.html",
        "蓬莱":"http://www.pm25.com/city/penglai.html",
        "包头":"http://www.pm25.com/city/baotou.html",
        "丽水":"http://www.pm25.com/city/lishui.html",
        "锦州":"http://www.pm25.com/city/jcom/cityzhou.html",
        "遵义":"http://www.pm25.com/city/zunyi.html",
        "泰州":"http://www.pm25.com/city/taizhoushi.html",
        "诸暨":"http://www.pm25.com/city/zhuji.html",
        "邯郸":"http://www.pm25.com/city/handan.html",
        "太仓":"http://www.pm25.com/city/taicang.html",
        "江阴":"http://www.pm25.com/city/jiangycom/city.html",
        "日照":"http://www.pm25.com/city/rizhao.html",
        "曲靖":"http://www.pm25.com/city/qujcom/cityg.html",
        "揭阳":"http://www.pm25.com/city/jieyang.html",
        "长治":"http://www.pm25.com/city/changzhi.html",
        "潍坊":"http://www.pm25.com/city/weifang.html",
        "齐齐哈尔":"http://www.pm25.com/city/qiqihaer.html",
        "宁波":"http://www.pm25.com/city/ncom/citygbo.html",
        "三门峡":"http://www.pm25.com/city/sanmenxia.html",
        "桂林":"http://www.pm25.com/city/guilcom/city.html",
        "平度":"http://www.pm25.com/city/pcom/citygdu.html",
        "舟山":"http://www.pm25.com/city/zhoushan.html",
        "沧州":"http://www.pm25.com/city/cangzhou.html",
        "惠州":"http://www.pm25.com/city/huizhou.html",
        "重庆":"http://www.pm25.com/city/chongqcom/cityg.html",
        "张家口":"http://www.pm25.com/city/zhangjiakou.html",
        "吉林":"http://www.pm25.com/city/jilcom/city.html",
        "镇江":"http://www.pm25.com/city/zhenjiang.html",
        "莱西":"http://www.pm25.com/city/laixi.html",
        "湛江":"http://www.pm25.com/city/zhanjiang.html",
        "阳江":"http://www.pm25.com/city/yangjiang.html",
        "宿迁":"http://www.pm25.com/city/suqian.html",
        "苏州":"http://www.pm25.com/city/suzhou.html",
        "中山":"http://www.pm25.com/city/zhongshan.html",
        "招远":"http://www.pm25.com/city/zhaoyuan.html",
        "三亚":"http://www.pm25.com/city/sanya.html",
        "嘉兴":"http://www.pm25.com/city/jiaxcom/cityg.html",
        "南京":"http://www.pm25.com/city/nanjcom/cityg.html",
        "洛阳":"http://www.pm25.com/city/luoyang.html",
        "厦门":"http://www.pm25.com/city/xiamen.html",
        "福州":"http://www.pm25.com/city/fuzhou.html",
        "大庆":"http://www.pm25.com/city/daqcom/cityg.html",
        "昆山":"http://www.pm25.com/city/kunshan.html",
        "清远":"http://www.pm25.com/city/qcom/citygyuan.html",
        "拉萨":"http://www.pm25.com/city/lasa.html",
        "泸州":"http://www.pm25.com/city/luzhou.html",
        "葫芦岛":"http://www.pm25.com/city/huludao.html",
        "攀枝花":"http://www.pm25.com/city/panzhihua.html",
        "荆州":"http://www.pm25.com/city/jcom/citygzhou.html",
        "牡丹江":"http://www.pm25.com/city/mudanjiang.html",
        "即墨":"http://www.pm25.com/city/jimo.html",
        "沈阳":"http://www.pm25.com/city/shenyang.html",
        "本溪":"http://www.pm25.com/city/benxi.html",
        "开封":"http://www.pm25.com/city/kaifeng.html",
        "德阳":"http://www.pm25.com/city/deyang.html",
        "连云港":"http://www.pm25.com/city/lianyungang.html",
        "保定":"http://www.pm25.com/city/baodcom/cityg.html",
        "青岛":"http://www.pm25.com/city/qcom/citygdao.html",
        "句容":"http://www.pm25.com/city/jurong.html",
        "兰州":"http://www.pm25.com/city/lanzhou.html",
        "咸阳":"http://www.pm25.com/city/xianyang.html",
        "呼和浩特":"http://www.pm25.com/city/huhehaote.html",
        "吴江":"http://www.pm25.com/city/wujiang.html",
        "延安":"http://www.pm25.com/city/yanan.html",
        "乳山":"http://www.pm25.com/city/rushan.html",
        "岳阳":"http://www.pm25.com/city/yueyang.html",
        "莱州":"http://www.pm25.com/city/laizhou.html",
        "营口":"http://www.pm25.com/city/ycom/citygkou.html",
        "莱芜":"http://www.pm25.com/city/laiwu.html",
        "烟台":"http://www.pm25.com/city/yantai.html",
        "衡水":"http://www.pm25.com/city/hengshui.html",
        "济宁":"http://www.pm25.com/city/jcom/citycom/cityg.html",
        "深圳":"http://www.pm25.com/city/shenzhen.html",
        "北海":"http://www.pm25.com/city/beihai.html",
        "衢州":"http://www.pm25.com/city/quzhou.html",
        "常州":"http://www.pm25.com/city/changzhou.html",
        "茂名":"http://www.pm25.com/city/maomcom/cityg.html",
        "抚顺":"http://www.pm25.com/city/fushun.html",
        "银川":"http://www.pm25.com/city/ycom/citychuan.html",
        "金昌":"http://www.pm25.com/city/jcom/citychang.html",
        "长春":"http://www.pm25.com/city/changchun.html",
        "临安":"http://www.pm25.com/city/lcom/cityan.html",
        "江门":"http://www.pm25.com/city/jiangmen.html",
        "溧阳":"http://www.pm25.com/city/liyang.html",
        "合肥":"http://www.pm25.com/city/hefei.html",
        "石家庄":"http://www.pm25.com/city/shijiazhuang.html",
        "库尔勒":"http://www.pm25.com/city/kuerle.html",
        "太原":"http://www.pm25.com/city/taiyuan.html",
        "湘潭":"http://www.pm25.com/city/xiangtan.html",
        "平顶山":"http://www.pm25.com/city/pcom/citygdcom/citygshan.html",
        "常德":"http://www.pm25.com/city/changde.html",
        "株洲":"http://www.pm25.com/city/zhuzhou.html",
        "绍兴":"http://www.pm25.com/city/shaoxcom/cityg.html",
        "肇庆":"http://www.pm25.com/city/zhaoqcom/cityg.html",
        "珠海":"http://www.pm25.com/city/zhuhai.html",
        "张家港":"http://www.pm25.com/city/zhangjiagang.html",
        "温州":"http://www.pm25.com/city/wenzhou.html",
        "梅州":"http://www.pm25.com/city/meizhou.html",
        "西安":"http://www.pm25.com/city/xian.html",
        "常熟":"http://www.pm25.com/city/changshu.html",
        "瓦房店":"http://www.pm25.com/city/wafangdian.html",
        "盘锦":"http://www.pm25.com/city/panjcom/city.html",
        "嘉峪关":"http://www.pm25.com/city/jiayuguan.html",
        "寿光":"http://www.pm25.com/city/shouguang.html",
        "成都":"http://www.pm25.com/city/chengdu.html",
        "九江":"http://www.pm25.com/city/jiujiang.html"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return indexSet.count
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSet[section].count
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return indexSet[section]
    }
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return indexSet
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel!.text = dataSet[indexPath.section][indexPath.row]
        return cell!
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let key = cell?.textLabel?.text
        let url = NSURL(string: urlData[key!]!)
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
//            let string = NSString(data: data!, encoding:NSUTF8StringEncoding)
//            print(string)
            if(data != nil)
            {
                self.parserData(data!)
                return
            }
            print("请求错误")
        }
        task.resume()
    }
    //html数据解析
    func parserData(data:NSData)
    {
        let doc = TFHpple(HTMLData: data,encoding: "UTF-8")
        let elementAQI = doc.searchWithXPathQuery("//div[@class='cbol_aqi']/a") as Array
        let elementPM = doc.searchWithXPathQuery("//div[@class='cbol_wuranwu']/a") as Array
        let elementPM25 = doc.searchWithXPathQuery("//a[@class='cbol_nongdu_num']/span") as NSArray
        if(doc != nil)
        {
            let name:TFHppleElement = elementAQI[0] as! TFHppleElement
            let name2:TFHppleElement = elementPM[0] as! TFHppleElement
            let name3:TFHppleElement = elementPM25[0] as! TFHppleElement
            
            if(name.firstChild.content != nil)
            {
                apiValue = name.firstChild.content
            }
            else
            {
                apiValue = "暂无数据"
            }
            if (name2.firstChild.content != nil)
            {
                pmVlaue = name2.firstChild.content
            }
            else
            {
                pmVlaue = "暂无数据"
            }
            if (name3.firstChild.content != nil)
            {
                pm25Value = name3.firstChild.content
            }
            else
            {
                pm25Value = "暂无数据"
            }
            //将查询的数据封装成模型
            model = ModelInfo(aqi: apiValue!,pm: pmVlaue!,pm25: pm25Value!)
            print("\(model?.AQI)+\(model?.pm)+\(model?.pm25)")
            return
        }
        print("请求出错！！")
    }
}

