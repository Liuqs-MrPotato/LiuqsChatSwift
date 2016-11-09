//
//  LiuqsChageEmotionStrTool.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/29.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class LiuqsChageEmotionStrTool: NSObject {
    
    static private let checkStr        = "\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]"
    
    static private var _emotionSize    = CGSize()
    
    static private var _font           = UIFont()
    
    static private var _textColor      = UIColor()
    
    static private var _matches        = NSArray()
    
    static private var _string         = String()
    
    static private var _emojiImages    = NSDictionary()
    
    static private var _imageDataArray = NSMutableArray()
    
    static private var _attStr         = NSMutableAttributedString()
    
    static private var _resultStr      = NSMutableAttributedString()
    

    static func changeStr(string:String, font:UIFont, textColor:UIColor) -> NSMutableAttributedString {
    
        _font      = font
        
        _string    = string
        
        _textColor = textColor
        //初始化
        initProperty()
        //获取匹对结果
        executeMatch()
        //遍历查询结果并保存
        setImageDataArray()
        //执行替换过程
        setResultStrUseReplace()
        //返回结果
        return _resultStr;
    }
    
    static func initProperty() {
    
        //读取对照表
        let path:String = Bundle.main.path(forResource: "LiuqsEmoji", ofType: "plist")!
        
        _emojiImages = NSDictionary.init(contentsOfFile: path)!
        //设置字体属性
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle();
    
        let attstrDic = [NSForegroundColorAttributeName:_textColor,NSFontAttributeName:_font,NSParagraphStyleAttributeName:paragraphStyle] as [String : Any]

        let maxsize:CGSize = CGSize.init(width: screenW, height: screenH)
        
        let str:String = "/"
        //根据字体获取单个表情的大小
        let emojiRect:CGRect = str.boundingRect(with: maxsize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attstrDic, context: nil)
        
        _emotionSize = emojiRect.size
        
        _attStr = NSMutableAttributedString.init(string: _string, attributes:attstrDic)
    }
    
    static func executeMatch() {
        
        var regex:NSRegularExpression = NSRegularExpression();
        
        do { regex = try NSRegularExpression.init(pattern: checkStr, options: .caseInsensitive)} catch{}
        
        let totalRange:NSRange = NSRange.init(location: 0, length: _string.characters.count)
        
        _matches = regex.matches(in: _string, options: [], range: totalRange) as NSArray
        
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
            
            let imageName:String? = _emojiImages.object(forKey: tagString) as? String
            
            if (imageName == nil) {continue};
            
            let image:UIImage = UIImage.init(named: imageName!)!
            
            attachMent.image = image
            
            let imageStr:NSAttributedString = NSAttributedString.init(attachment: attachMent)
            
            record.setObject(NSValue.init(range: matchRange), forKey: "range" as NSCopying)
            
            record.setObject(imageStr, forKey: "image" as NSCopying)
            
            imageDataArray.add(record)
            
        }
        _imageDataArray = imageDataArray
    }
    
    //这里必须倒着替换，不然会崩溃
    static func setResultStrUseReplace() {

        let result:NSMutableAttributedString = _attStr
        
        for i:Int in 0..<_imageDataArray.count {
            
            let imageDic:NSDictionary = _imageDataArray.object(at: _imageDataArray.count - i - 1) as! NSDictionary
            
            let range:NSRange = imageDic.object(forKey: "range") as! NSRange
            
            let imageStr:NSMutableAttributedString = imageDic.object(forKey: "image") as! NSMutableAttributedString
            
            print(range.location,range.length,result.length)
            
            result.replaceCharacters(in: range, with: imageStr)
        }
        _resultStr = result;
    }
    
}









