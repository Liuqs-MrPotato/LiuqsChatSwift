//
//  ChatListViewCell.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/8.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class ChatListViewCell: UITableViewCell {
    
    
    private lazy var iconImage   = UIImageView()
    
    private lazy var nameLabel   = UILabel()
    
    private lazy var detailLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        prepareUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareUI() {
        
        addSubview(iconImage)
        
        addSubview(nameLabel)
        
        addSubview(detailLabel)
        
        layout()
        
        initSomething()
    }
    
    private func initSomething() {
    
        iconImage.backgroundColor = UIColor.orange
        iconImage.layer.cornerRadius = 5.0;
        iconImage.layer.masksToBounds = true;
        iconImage.image = UIImage.init(named: "1")
        
        
        nameLabel.font      = UIFont.systemFont(ofSize: 17)
        nameLabel.text      = "和路飞的聊天"
        nameLabel.textColor = UIColor.gray
        
        
        detailLabel.font      = UIFont.systemFont(ofSize: 14)
        detailLabel.textColor = UIColor .lightGray
        detailLabel.text      = "左划可以删除哦"
        
    }
    
    private func layout() {
    
        iconImage.translatesAutoresizingMaskIntoConstraints = false;
        addConstraint(NSLayoutConstraint(item: iconImage, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 10))
        addConstraint(NSLayoutConstraint(item: iconImage, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 10))
        addConstraint(NSLayoutConstraint(item: iconImage, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 60))
        addConstraint(NSLayoutConstraint(item: iconImage, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 60))
        
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false;
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 5))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: iconImage, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 10))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 200))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 30))
        
        
        detailLabel.frame = CGRect.init(x: 75, y: 50, width: screenW - 60, height: 20)
        
    }
}


















