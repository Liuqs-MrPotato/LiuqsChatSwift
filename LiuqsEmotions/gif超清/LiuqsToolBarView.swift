//
//  LiuqsToolBarView.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/16.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

protocol LiuqsToolBarDelegate {
    
    func ToolbarEmotionBtnDidClicked(emotionBtn:UIButton)
}

class LiuqsToolBarView: UIImageView {

    var delegate:LiuqsToolBarDelegate?
    
    var textView:UITextView = UITextView()
    
    var toolBarEmotionBtn:UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = toolBarFrameDown
        
        self.isUserInteractionEnabled = true
        
        let line:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenW, height: 0.5))
        
        line.backgroundColor = UIColor.lightGray
        
        self.addSubview(line)
        
        self.backgroundColor = BACKGROUND_Color
        
        let textView:UITextView = UITextView.init(frame: CGRect.init(x: Lgap, y: Vgap, width: TextViewW, height: TextViewH))
        
        self.textView = textView
        
        textView.backgroundColor = UIColor.white
        
        textView.returnKeyType = UIReturnKeyType.send
        
        textView.layer.cornerRadius = 8
        
        textView.layer.borderWidth = 0.5
        
        textView.isScrollEnabled = true
        
        textView.layer.borderColor = UIColor.lightGray.cgColor;
        
        addSubview(textView)
        
        let emotionBtn:UIButton = UIButton.init(frame: CGRect.init(x: emotionBtnX, y: Vgap, width: emotionBtnW, height: emotionBtnH))
        
        self.toolBarEmotionBtn = emotionBtn;
        
        emotionBtn.setImage(UIImage.init(named: "emotionBtn_no"), for: UIControlState.normal)
        
        emotionBtn.setImage(UIImage.init(named: "emotionBtn_se"), for: UIControlState.selected)
        
        emotionBtn.addTarget(self, action: #selector(emotionBtnDidClicked(btn:)), for: UIControlEvents.touchUpInside)
        addSubview(emotionBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("初始化失败")
    }
    
    func emotionBtnDidClicked(btn:UIButton) {
    
        self.delegate?.ToolbarEmotionBtnDidClicked(emotionBtn: btn)
        
    }

}
