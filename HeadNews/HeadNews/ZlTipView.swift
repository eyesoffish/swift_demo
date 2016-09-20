//
//  ZlTipView.swift
//  HeadNews
//
//  Created by fengei on 16/8/30.
//  Copyright © 2016年 fengei. All rights reserved.
//

import UIKit
import SnapKit
class ZlTipView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ZLColor(215, g: 233, b: 246, a: 1.0)
        addSubview(tipLabel)
        tipLabel.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    // 提示标题
    lazy var tipLabel:UILabel = {
        let tiplabel = UILabel()
        tiplabel.textColor = ZLColor(91, g: 162, b: 207, a: 1.0)
        tiplabel.textAlignment = .Center
        tiplabel.transform = CGAffineTransformMakeScale(0.9, 0.9)
        return tiplabel
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
