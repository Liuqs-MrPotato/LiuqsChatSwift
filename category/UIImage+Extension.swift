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
}
