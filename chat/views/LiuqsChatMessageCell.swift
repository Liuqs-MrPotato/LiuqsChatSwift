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
    
    private var messageLabel:UIButton   = UIButton()
    
    private var gifimageView = UIImageView()

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

        self.backgroundColor = BACKGROUND_Color
        
        //头像
        iconImageView.layer.cornerRadius  = 5
        iconImageView.layer.masksToBounds = true
        contentView.addSubview(iconImageView)
        
        //消息
        messageLabel.titleLabel?.numberOfLines = 0
        contentView.addSubview(messageLabel)
        
        contentView.addSubview(gifimageView)
        
        //名字
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = UIColor.orange
        contentView.addSubview(nameLabel)
        
    }
    
    var chatCellFrame:LiuqsChatCellFrame? {
        
        didSet {
            
            let type:Bool = chatCellFrame?.message?.currentUserType == userType.me
            
            //头像
            let iconName:String = chatCellFrame?.message?.currentUserType == userType.me ? "1" : "2"
            iconImageView.setImage(UIImage.init(named: iconName), for: UIControlState.normal)
            iconImageView.frame = (chatCellFrame?.iconFrame)!
            //名字
            nameLabel.text = chatCellFrame?.message?.userName
            nameLabel.frame = (chatCellFrame?.nameFrame)!
            nameLabel.textAlignment = type ? NSTextAlignment.left : NSTextAlignment.right
            
            if chatCellFrame?.message?.messageType == 0 {
                
                //消息内容
                messageLabel.setAttributedTitle(chatCellFrame?.message?.attMessage, for: UIControlState.normal)
                messageLabel.frame = (chatCellFrame?.textFrame)!
                let messageImageName:String = type ? "chat_receive_nor" : "chat_send_nor"
                let messageImageNameP:String = type ? "chat_receive_p" : "chat_send_p"
                messageLabel.setBackgroundImage(UIImage.resizebleImage(imageName: messageImageName), for: UIControlState.normal)
                messageLabel.setBackgroundImage(UIImage.resizebleImage(imageName: messageImageNameP), for: UIControlState.highlighted)
                messageLabel.titleEdgeInsets = type ? UIEdgeInsetsMake(7, 13, 5, 5) : UIEdgeInsetsMake(5, 7, 5, 13)
                gifimageView.frame = CGRect()
                
            }else if chatCellFrame?.message?.messageType == 1 {
                
                let path:String = Bundle.main.path(forResource: chatCellFrame?.message?.gifName, ofType: "gif")!
                
                let data = NSData.init(contentsOf: NSURL.init(fileURLWithPath: path) as URL)
                
                let animationImage = UIImage.animationImageWithData(data: data);
             
                gifimageView.image =  animationImage;
                
                gifimageView.frame = (chatCellFrame?.imageViewFrame)!
                
                messageLabel.frame = CGRect()
            }
            
        }
    }
}
