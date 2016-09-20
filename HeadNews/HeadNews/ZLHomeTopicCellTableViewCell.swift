//
//  ZLHomeTopicCellTableViewCell.swift
//  HeadNews
//
//  Created by fengei on 16/9/13.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit
import SnapKit
class ZLHomeTopicCellTableViewCell: UITableViewCell {
    
    var filterWords:[ZLFilterWord]?
    
    var closeButtonClosure:((filterWords:[ZLFilterWord])->())?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        addSubview(titleLabel)
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(commentLabel)
        addSubview(titmeLabel)
        addSubview(stickLabel)
        addSubview(closeButton)
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.top.equalTo(self).offset(kHomeMargin)
            make.right.equalTo(self).offset(-kHomeMargin)
        }
        
        avatarImageView.snp_makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp_left)
            make.bottom.equalTo(self.snp_bottom).offset(-kHomeMargin)
            make.size.equalTo(CGSizeMake(16, 16))
        }
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp_left)
            make.centerY.equalTo(avatarImageView)
        }
        commentLabel.snp_makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp_right).offset(5)
            make.centerY.equalTo(nameLabel)
        }
        stickLabel.snp_makeConstraints { (make) in
            make.right.equalTo(titleLabel.snp_right)
            make.centerY.equalTo(avatarImageView)
            make.size.equalTo(CGSizeMake(17, 12))
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     *  置顶、热门、广告、视频
     */
    lazy var stickLabel:UIButton = {
       let stickLabel = UIButton()
        stickLabel.hidden = true
        stickLabel.layer.cornerRadius = 3
        stickLabel.sizeToFit()
        stickLabel.userInteractionEnabled = false
        stickLabel.titleLabel?.font = UIFont.systemFontOfSize(12)
        stickLabel.setTitleColor(ZLColor(341, g: 91, b: 94, a: 1.0), forState: .Normal)
        stickLabel.layer.borderColor = ZLColor(241, g: 91, b: 94, a: 1.0).CGColor
        stickLabel.layer.borderWidth = 0.5
        return stickLabel
    }()
    //新闻标题
    lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFontOfSize(17)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.blackColor()
        return titleLabel
    }()
    //用户名头像
    lazy var avatarImageView:UIImageView = {
        let avatarImageView = UIImageView()
        return avatarImageView
    }()
    //用户名
    lazy var nameLabel:UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFontOfSize(12)
        nameLabel.textColor = UIColor.lightGrayColor()
        return nameLabel
    }()
    //评论
    lazy var commentLabel:UILabel = {
        let commentLabel = UILabel()
        commentLabel.font = UIFont.systemFontOfSize(12)
        commentLabel.textColor = UIColor.lightGrayColor()
        return commentLabel
    }()
    //时间
    lazy var titmeLabel:UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFontOfSize(12)
        timeLabel.textColor = UIColor.lightGrayColor()
        return timeLabel
    }()
    //举报按钮
    lazy var closeButton:UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "add_textpage_17x12_"), forState: .Normal)
        closeButton.addTarget(self, action: #selector(closeButtonClick), forControlEvents: .TouchUpInside)
        return closeButton
    }()
    
    //举报按钮点击
    func closeButtonClick(){
    
    }
}
