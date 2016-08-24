//
//  LiuqsChatCellFrame.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/23.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class LiuqsChatCellFrame: NSObject {
    
    var iconFrame:CGRect         = CGRect()
    
    var nameFrame:CGRect         = CGRect()
    
    var gifFrame:CGRect          = CGRect()
    
    var textFrame:CGRect         = CGRect()
    
    var cellHeight:CGFloat       = CGFloat()
    
    private let iconW:CGFloat    = 50.0
    
    private let padding:CGFloat  = 10.0
    
    private let iconH:CGFloat    = 50.0
    
    
    
    var message:LiuqsChatMessage? {
    
        didSet {computeFrames()}
    }
    
    //计算frame
    func computeFrames() {
        
        let type:Bool = message?.currentUserType == userType.me
        
        let iconFrameX:CGFloat = type ? padding : screenW - padding - iconW
        
        let iconFrameY:CGFloat = padding
        
        let iconFrameW:CGFloat = iconW
        
        let iconFrameH:CGFloat = iconH
        
        iconFrame  = CGRect.init(x: iconFrameX, y: iconFrameY, width: iconFrameW, height: iconFrameH)
        
        cellHeight = 70
        
    }
    
 
    
    
    
    
}
