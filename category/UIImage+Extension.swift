//
//  UIImage+Extension.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/16.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit
import ImageIO

extension UIImage {

    ///用颜色创建一张图片
    static func createImageWithColor(color:UIColor) -> UIImage {
        
        let rect:CGRect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        
        context.fill(rect)
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return image
    }
    //拉伸一张图片
    static func resizebleImage(imageName:String) -> UIImage {
    
        var imageNor = UIImage.init(named: imageName)
        
        let w = imageNor?.size.width
        
        let h = imageNor?.size.height
        
        imageNor = imageNor?.resizableImage(withCapInsets: UIEdgeInsetsMake(w! * 0.5, h! * 0.5, w! * 0.5, h! * 0.5), resizingMode: UIImageResizingMode.stretch)
        
        return imageNor!
    }

    //gif图片解析
    static func animationImageWithData(data:NSData?) -> UIImage {
        
        if data != nil {
            
            let source:CGImageSource = CGImageSourceCreateWithData(data as! CFData, nil)!
            
            let count:size_t = CGImageSourceGetCount(source)
            
            var animatedImage:UIImage?
            
            if count <= 1 {
                
                animatedImage = UIImage.init(data: data as! Data)
                
            }else {
                
                var images = [UIImage]()
                
                var duration:TimeInterval = 0.0;
                
                for i:size_t in size_t(0.0) ..< count {
                    
                    let image:CGImage? = CGImageSourceCreateImageAtIndex(source, i, nil)!
                    
                    if image == nil {
                        
                        continue
                    }
                    duration = TimeInterval(frameDuration(index: i, source: source)) + duration;
                    
                    images.append(UIImage.init(cgImage: image!))
                }
                if (duration == 0.0) {
                    
                    duration = Double(1.0 / 10.0) * Double(count);
                }
                animatedImage = UIImage.animatedImage(with: images, duration: 2.0);
            }
            
            return animatedImage!
        }else {
        
            return UIImage()
        }
        
    }
    
    static func frameDuration(index:Int,source:CGImageSource) -> Float {
    
    
        var frameDuration:Float = 0.1;
        
        let cfFrameProperties:CFDictionary = CGImageSourceCopyPropertiesAtIndex(source, index, nil)!
        
        let frameProperties:NSDictionary = cfFrameProperties as CFDictionary
        
        let gifProperties:NSDictionary = frameProperties.object(forKey: kCGImagePropertyGIFDictionary as NSString) as! NSDictionary
        
        let delayTimeUnclampedProp:NSNumber? = gifProperties.object(forKey: kCGImagePropertyGIFUnclampedDelayTime as NSString) as? NSNumber

        if delayTimeUnclampedProp != nil {
            
            frameDuration = (delayTimeUnclampedProp?.floatValue)!
        }else {
        
            let delayTimeProp:NSNumber? = gifProperties.object(forKey: kCGImagePropertyGIFDelayTime as NSString) as? NSNumber
            
            if delayTimeProp != nil {
                
                frameDuration = (delayTimeProp?.floatValue)!
            }
            
            if frameDuration < 0.011{
                
                frameDuration = 0.100;
            }
        }
      return frameDuration
    }
}



























