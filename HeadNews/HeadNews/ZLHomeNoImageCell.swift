//
//  ZLHomeNoImageCell.swift
//  HeadNews
//
//  Created by fengei on 16/9/14.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

class ZLHomeNoImageCell: ZLHomeTopicCellTableViewCell {
    var newsTopic:ZLNewsTopic?{
        didSet{
            titleLabel.text = String(newsTopic?.title!)
            if let publishTime = newsTopic?.publish_time{
                titmeLabel.text = NSString.changeDateTime(publishTime)
            }
            
            if let sourceAvatar = newsTopic?.source_avatar{
                nameLabel.text = newsTopic?.source
                avatarImageView.setCircleHeader(sourceAvatar)
            }
            
            if let mediaInfo = newsTopic?.media_info{
                nameLabel.text = mediaInfo.name
                avatarImageView.setCircleHeader(mediaInfo.avatar_url!)
            }
            
            if let commentcount = newsTopic?.comment_count {
                commentcount >= 10000 ? (commentLabel.text = "\(commentcount / 10000)万评论") : (commentLabel.text = "\(commentcount)评论")
            }else{
                commentLabel.hidden = true
            }
            
            filterWords = newsTopic?.filter_words
            if let label = newsTopic?.label{
                stickLabel.setTitle("\(label)", forState: .Normal)
                stickLabel.hidden = false
                closeButton.hidden = (label == "置顶") ? true : false
            }
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //举报按钮点击
    override func closeButtonClick() {
        closeButtonClosure?(filterWords:filterWords!)
    }
    //举报按钮回调
    func closeBtnClick(closure:(filterWord:[ZLFilterWord])->()){
        closeButtonClosure = closure
    }
}
