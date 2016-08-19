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

    var delegate:LiuqsTabBarDelegate?
    
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
        
//
//        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(Lgap, Vgap, TextViewW, TextViewH)];
//        self.textView = textView;
//        textView.backgroundColor = [UIColor whiteColor];
//        textView.returnKeyType = UIReturnKeySend;
//        textView.layer.cornerRadius = 8;
//        textView.layer.borderWidth = 0.5f;
//        textView.scrollEnabled = YES;
//        [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 1)];
//        textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        [self addSubview:textView];
        
        let textView:UITextView = UITextView.init(frame: CGRect.init(x: Lgap, y: Vgap, width: TextViewW, height: TextViewH))
        
        self.textView = textView
        
        textView.backgroundColor = UIColor.white
        
        textView.returnKeyType = UIReturnKeyType.send
        
        textView.layer.cornerRadius = 8
        
        textView.layer.borderWidth = 0.5
        
        textView.isScrollEnabled = true
        
//        textView.scrollRangeToVisible(NSRange.init(location: textView.text.l, length: <#T##Int#>))
        
       /* UIButton *emotionBtn = [[UIButton alloc]initWithFrame:CGRectMake(emotionBtnX, Vgap, emotionBtnW, emotionBtnH)];
        self.toolBarEmotionBtn = emotionBtn;
        [emotionBtn setImage:[UIImage imageNamed:@"emotionBtn_no"] forState:UIControlStateNormal];
        [emotionBtn setImage:[UIImage imageNamed:@"emotionBtn_se"] forState:UIControlStateSelected];
        [emotionBtn addTarget:self action:@selector(emotionBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:emotionBtn];*/

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("初始化失败")
    }

}
