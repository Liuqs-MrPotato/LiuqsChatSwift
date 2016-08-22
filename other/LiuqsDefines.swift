//
//  LiuqsDefines.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/8.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

let screenW = UIScreen.main.bounds.size.width

let screenH = UIScreen.main.bounds.size.height

let EMOJI_KEYBOARD_HEIGHT:CGFloat = (4 * screenW * 0.0875 + (3 + 1) * ((screenW - 7 * screenW * 0.0875 ) / 8) + 20)

let BLUE_Color:UIColor = UIColor(red: 22.0 / 255.0, green: 128.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)

let BACKGROUND_Color:UIColor = UIColor(red: 235.0 / 255.0, green: 235.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)


///toolbar
let toobarH:CGFloat     = screenW * 44 / 320

let TextViewW:CGFloat   = screenW - (screenW * 55 / 320)

let TextViewH:CGFloat   = screenW * 34 / 320

let emotionBtnW:CGFloat = screenW * 34 / 320

let emotionBtnH:CGFloat = screenW * 34 / 320

let emotionBtnX:CGFloat = screenW - (screenW * 40 / 320)

let toolBarFrameDown    = CGRect(x:0, y:screenH - toobarH, width:screenW, height:toobarH)

let toolBarFrameUPBaseEmotion = CGRect(x:0, y:screenH - toobarH - EMOJI_KEYBOARD_HEIGHT, width:screenW, height:toobarH)

let Vgap:CGFloat = screenW * 5 / 320

let Lgap:CGFloat = screenW * 10 / 320

///emotionView
let emotionUpFrame:CGRect = CGRect.init(x: 0, y: screenH - (EMOJI_KEYBOARD_HEIGHT), width: screenW, height: EMOJI_KEYBOARD_HEIGHT)

let emotionDownFrame = CGRect.init(x: 0, y: screenH, width: screenW, height: 0)

let emotionTipTime  = 0.25


