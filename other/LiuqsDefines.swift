//
//  LiuqsDefines.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/8.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

public let screenW = UIScreen.main.bounds.size.width

public let screenH = UIScreen.main.bounds.size.height

public let EMOJI_KEYBOARD_HEIGHT = (4 * screenW * 0.0875 + (3 + 1) * ((screenW - 7 * screenW * 0.0875 ) / 8) + 20)

public let BLUE_Color            = UIColor(red: 22.0 / 255.0, green: 128.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)

public let BACKGROUND_Color      = UIColor(red: 235.0 / 255.0, green: 235.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)

public let navColor              = UIColor.init(red: 57 / 255, green: 56 / 255, blue: 54 / 255, alpha: 1.0)


///toolbar
public let toobarH          = screenW * 44 / 320

public let TextViewW        = screenW - (screenW * 55 / 320)

public let TextViewH        = screenW * 34 / 320

public let emotionBtnW      = screenW * 34 / 320

public let emotionBtnH      = screenW * 34 / 320

public let emotionBtnX      = screenW - (screenW * 40 / 320)

public let toolBarFrameDown = CGRect(x:0, y:screenH - toobarH, width:screenW, height:toobarH)

public let toolBarFrameUPBaseEmotion = CGRect(x:0, y:screenH - toobarH - EMOJI_KEYBOARD_HEIGHT, width:screenW, height:toobarH)

public let Vgap = screenW * 5 / 320

public let Lgap = screenW * 10 / 320

///emotionView
public let emotionUpFrame   = CGRect.init(x: 0, y: screenH - (EMOJI_KEYBOARD_HEIGHT), width: screenW, height: EMOJI_KEYBOARD_HEIGHT)

public let emotionDownFrame = CGRect.init(x: 0, y: screenH, width: screenW, height: EMOJI_KEYBOARD_HEIGHT)

public let emotionTipTime   = 0.25


