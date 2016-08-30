//
//  UIImage+Extension.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/16.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

extension UIImage {

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
    
    
    static func resizebleImage(imageName:String) -> UIImage {
    
        var imageNor = UIImage.init(named: imageName)
        
        let w = imageNor?.size.width
        
        let h = imageNor?.size.height
        
        imageNor = imageNor?.resizableImage(withCapInsets: UIEdgeInsetsMake(w! * 0.5, h! * 0.5, w! * 0.5, h! * 0.5), resizingMode: UIImageResizingMode.stretch)
        
        return imageNor!
    }
    
    static func animationImage(gifName:String) -> UIImage {
        
       return UIImage()
    }
}































