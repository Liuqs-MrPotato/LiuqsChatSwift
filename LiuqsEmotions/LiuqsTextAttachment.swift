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

extension NSAttributedString {
    

    func getPlainString() -> String {
    
         let plainString = NSMutableString.init(string: self.string)
        
        var base:Int = 0
        
        self .enumerateAttribute(NSAttachmentAttributeName, in: NSRange.init(location: 0, length: self.length), options: []) { (value, range:NSRange, stop) in
            
            if (value != nil) {
            
                let emoji:LiuqsTextAttachment = value as! LiuqsTextAttachment
                
                print(base,emoji.emojiTag)
                
                plainString.replaceCharacters(in: NSRange.init(location: range.location + base, length: range.length), with: emoji.emojiTag)
                
                base = base + Int(emoji.emojiTag.characters.count - 1)
            }
        }
        
       return plainString as String
    }
}
