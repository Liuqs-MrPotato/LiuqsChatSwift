//
//  ChatDetailViewController.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/8.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class ChatDetailViewController: UIViewController {
    
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
        
        self.view.addSubview(emotionview)
    }

    func initSomething() {
        
        self.view.backgroundColor = BACKGROUND_Color
        
        self.automaticallyAdjustsScrollViewInsets = false
    
    }
    
    lazy private var emotionview:LiuqsEmotionKeyBoard = {
    
        let emotionview = LiuqsEmotionKeyBoard.init(frame: CGRect.init(x: 0, y: screenH - EMOJI_KEYBOARD_HEIGHT, width: screenW, height: EMOJI_KEYBOARD_HEIGHT))
        return emotionview
    }()

}
