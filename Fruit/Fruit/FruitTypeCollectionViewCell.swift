//
//  FruitTypeCollectionViewCell.swift
//  Fruit
//
//  Created by fengei on 16/6/22.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

class FruitTypeCollectionViewCell: UICollectionViewCell {
    var image:UIImage?{
        get{
            return self.myImage.image
        }
        set
        {
            self.myImage.image = newValue
        }
    }
    var title:String?{
        get{
            return self.labelTitle.text
        }
        set
        {
            self.labelTitle.text = newValue
        }
    }
    var myImage:UIImageView!
    var labelTitle:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        MyAdd()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func MyAdd()
    {
        myImage = UIImageView()
        myImage.frame = BQAdaptationFrame(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-40)
        labelTitle = UILabel()
        labelTitle.frame = CGRectMake(0, CGRectGetHeight(self.frame)-40, CGRectGetWidth(self.frame), 40)
        labelTitle.textColor = UIColor.whiteColor()
//        labelTitle.textColor = UIColor(red: 247/255.0, green: 163/255.0, blue: 2/255.0, alpha: 1)
        labelTitle.backgroundColor = UIColor(red: 255/255.0, green: 227/255.0, blue: 67/255.0, alpha: 1)
        labelTitle.textAlignment = NSTextAlignment.Center
        self.addSubview(myImage)
        self.addSubview(labelTitle)
    }
}
