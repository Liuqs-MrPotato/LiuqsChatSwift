//
//  LiuqsTextAttachment.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/22.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class LiuqsTextAttachment: NSTextAttachment {
    
    var emojiTag:String     = String()
    
    var emojiSize:CGSize    = CGSize()
    
    override func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
        
        return CGRect.init(x: 0, y: -4, width: emojiSize.width, height: emojiSize.height)
    }
    
}
