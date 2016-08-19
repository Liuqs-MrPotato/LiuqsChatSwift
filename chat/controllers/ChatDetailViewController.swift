//
//  ChatDetailViewController.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/8.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class ChatDetailViewController: UIViewController ,LiuqsToolBarDelegate ,UITextViewDelegate{
    
    var toolBarView:LiuqsToolBarView = LiuqsToolBarView.init(frame: CGRect())
    
    lazy private var emotionview:LiuqsEmotionKeyBoard = {
        
        let emotionview = LiuqsEmotionKeyBoard.init(frame: CGRect.init(x: 0, y: screenH, width: screenW, height: EMOJI_KEYBOARD_HEIGHT))
        
        self.view.addSubview(emotionview)
        
        return emotionview
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(true)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initSomething()
        
        creatToolBarView()
        
        self.view.addSubview(emotionview)

    }

    func initSomething() {
        
        self.view.backgroundColor = BACKGROUND_Color
        
        self.automaticallyAdjustsScrollViewInsets = false
    
    }
    

    func creatToolBarView() {
    
        toolBarView.delegate = self
        
        toolBarView.textView.delegate = self
        
        self.view.addSubview(toolBarView)
        
    }
    
    //toolBar代理
    func ToolbarEmotionBtnDidClicked(emotionBtn: UIButton) {
    
//        if (emotionBtn.selected) {
//            emotionBtn.selected = NO;
//            [self.textView becomeFirstResponder];
//            self.tableView.height = screenH - self.keyBoardH - self.toolBarView.height - 64;
//        }else
//        {
//            [self.textView resignFirstResponder];
//            emotionBtn.selected = YES;
//            [UIView animateWithDuration:emotionTipTime animations:^{
//                self.emotionview.frame = emotionUpFrame;
//                self.toolBarView.frame = CGRectMake(0, screenH - self.toolBarView.height - self.emotionview.height, screenW, self.toolBarView.height);
//                self.tableView.height = screenH - self.emotionview.height - self.toolBarView.height - 64;
//                if (self.tableView.contentSize.height > self.tableView.height) {
//                [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height + 3) animated:NO];
//                }
//                }];
//        }
        
        if emotionBtn.isSelected {
        
            emotionBtn.isSelected = false;
            
            toolBarView.textView.becomeFirstResponder()
            
        }else {
        
            toolBarView.textView.resignFirstResponder()
            
            emotionBtn.isSelected = true
            
            UIView.animate(withDuration: emotionTipTime, animations: { 
                
                self.emotionview.frame = emotionUpFrame
                
                self.toolBarView.frame = CGRect.init(x: 0, y: screenH - self.toolBarView.frame.size.height - self.emotionview.frame.size.height, width: screenW, height: self.toolBarView.frame.size.height)
                
            })
        }
        
        
    }
}
