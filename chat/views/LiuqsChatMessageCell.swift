//
//  LiuqsChatMessageCell.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/23.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class LiuqsChatMessageCell: UITableViewCell {
    
    private var iconImageView:UIButton = UIButton()
    
    private var nameLabel:UILabel      = UILabel()
    
    private var messageLabel:UILabel   = UILabel()

    static func cellWithTableView(tableView:UITableView) ->LiuqsChatMessageCell {
    
        let ID:String = "LiuqsChatMessageCell"
        
        let cell:LiuqsChatMessageCell = tableView.dequeueReusableCell(withIdentifier: ID) as! LiuqsChatMessageCell
        
        return cell
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareUI() {
    
        iconImageView.backgroundColor     = UIColor.orange
        iconImageView.layer.cornerRadius  = 5
        iconImageView.layer.masksToBounds = true
        contentView.addSubview(iconImageView)
        
        
    }
    
    var chatCellFrame:LiuqsChatCellFrame? {
        
        didSet {
            
            let iconName:String = chatCellFrame?.message?.currentUserType == userType.me ? "1" : "2"
            iconImageView.setImage(UIImage.init(named: iconName), for: UIControlState.normal)
            iconImageView.frame = (chatCellFrame?.iconFrame)!
            
        }
    }
}
