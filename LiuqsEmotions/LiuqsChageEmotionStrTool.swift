//
//  LiuqsChageEmotionStrTool.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/29.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class LiuqsChageEmotionStrTool: NSObject {
    
    static private let checkStr = "\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]"
    
    static private var _emotionSize:CGSize = CGSize()
    
    static private var _font:UIFont        = UIFont()
    
    static private var _textColor:UIColor  = UIColor()
    
    static private var _matches:NSArray    = NSArray()
    
    static private var _string:String      = String()
    
    static private var _emojiImages:NSDictionary            = NSDictionary()
    
    static private var _imageDataArray:NSMutableArray       = NSMutableArray()
    
    static private var _attStr:NSMutableAttributedString    = NSMutableAttributedString()
    
    static private var _resultStr:NSMutableAttributedString = NSMutableAttributedString()
    

    static func changeStr(string:String, font:UIFont, textColor:UIColor) -> NSMutableAttributedString {
    
        _font      = font
        
        _string    = string
        
        _textColor = textColor
        
        initProperty()
        
        executeMatch()
        
        setImageDataArray()

        setResultStrUseReplace()
        
        return _resultStr;
    }
    
    static func initProperty() {
    
        //读取对照表
        let path:String = Bundle.main.path(forResource: "LiuqsEmoji", ofType: "plist")!
        
        _emojiImages = NSDictionary.init(contentsOfFile: path)!
        
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle();
    
        let attstrDic = [NSForegroundColorAttributeName:_textColor,NSFontAttributeName:_font,NSParagraphStyleAttributeName:paragraphStyle]

        let maxsize:CGSize = CGSize.init(width: screenW, height: screenH)
        
        let str:String = "/"
        
        let emojiRect:CGRect = str.boundingRect(with: maxsize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attstrDic, context: nil)
        
        _emotionSize = emojiRect.size
        
        
        _attStr = NSMutableAttributedString.init(string: _string, attributes:attstrDic)
    }
    
    static func executeMatch() {
        
        var regex:NSRegularExpression = NSRegularExpression();
        
        do { regex = try NSRegularExpression.init(pattern: checkStr, options: .caseInsensitive)} catch{}
        
        let totalRange:NSRange = NSRange.init(location: 0, length: _string.characters.count)
        
        _matches = regex.matches(in: _string, options:[], range:totalRange).reversed()
        
    }
    
    static func setImageDataArray() {
        
        let imageDataArray:NSMutableArray = NSMutableArray()
        
        for i:Int in 0..<_matches.count {
            
            let record:NSMutableDictionary = NSMutableDictionary()
            
            let attachMent:LiuqsTextAttachment = LiuqsTextAttachment()
            
            attachMent.emojiSize = CGSize.init(width: _emotionSize.height, height: _emotionSize.height)
            
            let match:NSTextCheckingResult = _matches.object(at: i) as! NSTextCheckingResult
            
            let matchRange:NSRange = match.range
            
            let str:NSString = _string as NSString
            
            let tagString:String = String(str.substring(with: matchRange))
            
            let imageName:String = _emojiImages.object(forKey: tagString) as! String
            
            if (imageName == "" || imageName.characters.count == 0) {continue};
            
            //这里有一个bug不知道怎么处理
            var imageData:NSData = NSData()
            
            let path:String = Bundle.main.path(forResource: imageName, ofType: "png")!
            
            do {try imageData = NSData.init(contentsOfFile: path)} catch{return}
            
            attachMent.image = UIImage.init(data: imageData as Data)
            
            let imageStr:NSAttributedString = NSAttributedString.init(attachment: attachMent)
            
            record.setObject(NSValue.init(range: matchRange), forKey: "range")
            
            record.setObject(imageStr, forKey: "image")
            
            imageDataArray.add(record)
        }
        _imageDataArray = imageDataArray
        
    }
    
    static func setResultStrUseReplace() {

        let result:NSMutableAttributedString = _attStr
        
        for i:Int in 0..<_imageDataArray.count {
            
            let imageDic:NSDictionary = _imageDataArray.object(at: i) as! NSDictionary
            
            let range:NSRange = (imageDic.object(forKey: "range")?.rangeValue)!
            
            let imageStr:NSMutableAttributedString = imageDic.object(forKey: "image") as!NSMutableAttributedString
            
            result.replaceCharacters(in: range, with: imageStr)
        }
        
        _resultStr = result;
    }
    
}









