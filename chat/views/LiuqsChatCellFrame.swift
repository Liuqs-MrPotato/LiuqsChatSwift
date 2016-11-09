//
//  LiuqsChatCellFrame.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/23.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class LiuqsChatCellFrame: NSObject {
    
    var iconFrame         = CGRect()
    
    var nameFrame         = CGRect()
    
    var textFrame         = CGRect()
    
    var imageViewFrame    = CGRect()
    
    var cellHeight        = CGFloat()
    
    private let iconW:CGFloat    = 50.0
    
    private let padding:CGFloat  = 10.0
    
    private let iconH:CGFloat    = 50.0
    
    var message:LiuqsChatMessage? {
    
        didSet {computeFrames()}
    }
    
    //计算frame
    func computeFrames() {
        
        let type:Bool = message?.currentUserType == userType.me
        //头像
        let iconFrameX:CGFloat = type ? padding : screenW - padding - iconW
        let iconFrameY:CGFloat = padding
        let iconFrameW:CGFloat = iconW
        let iconFrameH:CGFloat = iconH
        iconFrame  = CGRect.init(x: iconFrameX, y: iconFrameY, width: iconFrameW, height: iconFrameH)
        
        //名字
        nameFrame = type ? CGRect.init(x: iconFrame.maxX + padding, y: iconFrameY, width: 100, height: 25) : CGRect.init(x: screenW - padding * 2 - iconFrameW - 100, y: iconFrameY, width: 100, height: 25)
        
        if message?.messageType == 0 {
          
            //message
            let str:String = (message?.message)!
            let textAtt = LiuqsChageEmotionStrTool.changeStr(string: str, font: UIFont.systemFont(ofSize: 17.0), textColor: UIColor.black)
            message?.attMessage = textAtt
            let maxsize:CGSize = CGSize.init(width: Int(screenW - (iconFrameW + padding * 3) * 2), height: 1000)
            let textSize:CGSize = textAtt.boundingRect(with: maxsize, options: .usesLineFragmentOrigin, context: nil).size
            let emojiSize:CGSize = CGSize.init(width: textSize.width + padding * 2, height: textSize.height + padding * 2)
            textFrame = type ? CGRect.init(x: padding * 2 + iconFrameW, y: iconFrameY + iconFrameH * 0.5, width: emojiSize.width, height: emojiSize.height) : CGRect.init(x: screenW - padding * 2 - iconFrameW - emojiSize.width, y: iconFrameY + iconFrameH * 0.5, width: emojiSize.width, height: emojiSize.height)
            cellHeight = textFrame.maxY + padding;
        }else if message?.messageType == 1 {
        
            imageViewFrame = type ? CGRect.init(x: padding * 2 + iconFrameW, y: iconFrameY + iconFrameH * 0.5, width: 100, height: 100) : CGRect.init(x: screenW - padding * 2 - iconFrameW - 100, y: iconFrameY + iconFrameH * 0.5, width: 100, height: 100);
            
            cellHeight = imageViewFrame.maxY + padding;
            
        }else {
    
            
        }
    }
    
}
