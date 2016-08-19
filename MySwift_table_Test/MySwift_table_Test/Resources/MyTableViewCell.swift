//
//  MyTableViewCell.swift
//  MySwift_table_Test
//
//  Created by fengei on 16/5/21.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    var name:String{
        get{
            return self.labelName!.text!
        }
        set{
            self.labelName.text = newValue
        }
    }
    var myImage:UIImage{
        get{
            return self.headImage!.image!
        }
        set{
            self.headImage!.image = newValue
        }
    }
    var MyDesc:String{
        get{
            return self.labelDesc!.text!
        }
        set{
            self.labelDesc!.text = newValue
        }
    }
    var url:String?
    
    var headImage:UIImageView!
    var labelName:UILabel!
    var labelDesc:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        MyAdd()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func MyAdd(){
        headImage = UIImageView(frame:CGRectMake(10, 10, 80, 55))
        labelDesc = UILabel(frame:CGRectMake(95,35,250,40))
        labelDesc.font = UIFont.systemFontOfSize(10, weight: 0.5)
        labelName = UILabel(frame:CGRectMake(95,10,200,20))
        labelName.font = UIFont.systemFontOfSize(20, weight: 1)
        
        labelDesc.textAlignment = NSTextAlignment.Left
        labelName.textAlignment = NSTextAlignment.Left
        labelDesc.lineBreakMode = NSLineBreakMode.ByWordWrapping
        labelDesc.numberOfLines = 0
        self.contentView.addSubview(headImage)
        self.contentView.addSubview(labelName)
        self.contentView.addSubview(labelDesc)
    }
    // getter and setter
}
