//
//  FruitTypesViewController.swift
//  Fruit
//
//  Created by fengei on 16/6/22.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

class FruitTypesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var array:NSArray!
    var collectView:UICollectionView!
    var layout:UICollectionViewFlowLayout!
    var lableTitle:UILabel!
    var infoView:FruitInfoView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        array = ["哈密瓜","芒果","橙子","柠檬","桃","柿子","乌梅","山楂","人参果","火龙果","樱桃","桔子","猕猴桃","柚子","枣","山竹","杏李","桑葚","菠萝","草莓","潘石榴","梨","榴莲","石榴","椰子","水果玉米","荔枝","香蕉","苹果","木瓜","西瓜","甘蔗","葡萄","橄榄"]
        MyAdd()
//        self.collectView.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        self.collectView.registerClass(FruitTypeCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func MyAdd()
    {
        let width = (CGRectGetWidth(self.view.frame)-20)/3.0
        layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 5;
        layout.itemSize = BQadaptationSize(width, width+40)
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        
        collectView = UICollectionView(frame: BQAdaptationFrame(0, 60, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)), collectionViewLayout: layout)
        collectView.backgroundColor = UIColor.clearColor()
        collectView.delegate = self
        collectView.dataSource = self
        
        lableTitle = UILabel()
        lableTitle.frame = BQAdaptationFrame(5, 0, CGRectGetWidth(self.view.frame)-10, 60)
        lableTitle.text = "水果种类"
        lableTitle.font = UIFont.boldSystemFontOfSize(25)
        lableTitle.textColor = UIColor.whiteColor()
        lableTitle.textAlignment = NSTextAlignment.Center
        lableTitle.backgroundColor = UIColor(red: 255/255.0, green: 227/255.0, blue: 67/255.0, alpha: 1)
        
        
        
        self.view.addSubview(collectView)
        self.view.addSubview(lableTitle)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:FruitTypeCollectionViewCell = collectView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! FruitTypeCollectionViewCell
        cell.title = array[indexPath.row] as? String
        cell.image = UIImage(named: (array[indexPath.row] as! String)+".jpg")
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = UIColor.grayColor().CGColor
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        print(array[indexPath.row] as! String)
        let path = NSBundle.mainBundle().pathForResource(array[indexPath.row] as? String, ofType: "txt")
        let res = readTXT(path!)
        let title = (array[indexPath.row] as! String)
        let tempImage = UIImage(named: title+".jpg")
        infoView = FruitInfoView(frame:self.view.bounds)
        infoView.title = title
        infoView.image = tempImage
        infoView.text = res
        self.view.addSubview(infoView)
    }
    func readTXT(path:String) -> String
    {
        if path.isEmpty
        {
            return ""
        }
        else
        {
            let data = NSData(contentsOfFile: path)
            return String(data:data!,encoding: NSUTF8StringEncoding)!
        }
    }
}
