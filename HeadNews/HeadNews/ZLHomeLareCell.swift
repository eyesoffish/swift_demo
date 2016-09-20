//
//  ZLHomeLareCell.swift
//  HeadNews
//
//  Created by fengei on 16/9/14.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit

class ZLHomeLareCell: ZLHomeTopicCellTableViewCell {
    
    var newTopic:ZLNewsTopic?{
        didSet{
            titleLabel.text = String(newTopic?.title!)
            titmeLabel.text = NSString.changeDateTime(newTopic!.publish_time!)
            if let sourceAvatar = newTopic?.source_avatar{
                nameLabel.text = newTopic?.source!
                avatarImageView.setCircleHeader(sourceAvatar)
            }
            
            if let mediaInfo = newTopic?.media_info{
                nameLabel.text = mediaInfo.name
                avatarImageView.setCircleHeader(mediaInfo.avatar_url!)
            }
            
            if let commentCount = newTopic?.comment_count{
                commentCount >= 10000 ? (commentLabel.text = "\(commentCount / 10000)万评论") : (commentLabel.text = "\(commentCount)评论")
            }else{
                commentLabel.hidden = true
            }
            
            filterWords = newTopic?.filter_words
            
            var urlString = String()
            
            if let videoDetailInfo = newTopic?.video_detail_info{
                //说明是视频
                urlString = videoDetailInfo.detail_video_large_image!.url!
                let minute = Int(newTopic!.video_duration! / 60)
                let second = newTopic!.video_duration! % 60
                rightBottomLabel.text = String(format: "%02d:%02d", minute, second)
            }else{//说明是大图
                playButton.hidden = true
                urlString = newTopic!.large_image_list.first!.url!
                rightBottomLabel.text = "\(newTopic?.gallary_image_count)图"
            }
            
            largeImageView.kf_setImageWithURL(NSURL(string: urlString)!)
            if let label = newTopic?.label{
                if label == ""{
                    stickLabel.hidden = true
                }
                else{
                    stickLabel.setTitle("\(label)", forState: .Normal)
                    stickLabel.hidden = false
                }
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(largeImageView)
        largeImageView.addSubview(rightBottomLabel)
        largeImageView.addSubview(playButton)
        
        largeImageView.snp_makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(kMargin)
            make.left.equalTo(titleLabel.snp_left)
            make.right.equalTo(titleLabel.snp_right)
            make.size.equalTo(CGSizeMake(SCREENW - 30, 170))
        }
        
        rightBottomLabel.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(50, 20))
            make.right.equalTo(largeImageView.snp_right).offset(-7)
            make.bottom.equalTo(largeImageView.snp_bottom).offset(-7)
        }
        
        playButton.snp_makeConstraints { (make) in
            make.center.equalTo(largeImageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //中间大图
    private lazy var largeImageView:UIImageView = {
        let largeImageView = UIImageView()
        largeImageView.backgroundColor = UIColor.lightGrayColor()
        return largeImageView
    }()
    
    private lazy var playButton: UIButton = {
       let playButton = UIButton()
        playButton.setImage(UIImage(named: "playicon_video_60x60_"), forState: .Normal)
        playButton.sizeToFit()
        playButton.addTarget(self, action: #selector(playButtonClick), forControlEvents: .TouchUpInside)
        return playButton
    }()
    lazy var rightBottomLabel:UILabel = {
        let rightBottomLabel = UILabel()
        rightBottomLabel.textAlignment = .Center
        rightBottomLabel.layer.cornerRadius = 10
        rightBottomLabel.layer.masksToBounds = true
        rightBottomLabel.font = UIFont.systemFontOfSize(13)
        rightBottomLabel.textColor = UIColor.whiteColor()
        rightBottomLabel.backgroundColor = ZLColor(0, g: 0, b: 0, a: 0.6)
        return rightBottomLabel
    }()
    //举报按钮点击
    override func closeButtonClick() {
        closeButtonClosure?(filterWords:filterWords!)
    }
    //播放按钮点击
    func playButtonClick(){
        
    }
    //举报按钮点击回调
    func closeButtonClick(closure:(filterWord:[ZLFilterWord])->()){
        closeButtonClosure = closure
    }
    
}
