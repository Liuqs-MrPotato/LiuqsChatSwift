//
//  AddViewController.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/14.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UINavigationControllerDelegate {
    
    var CancelBtn:UIButton = UIButton.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSomething()
        createCancelBtn()
        createNotiLabel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        addtransAnimation()
        
        self.navigationController?.navigationBar.isHidden = true;
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
    
        return UIStatusBarStyle.lightContent
    }
    
    func createNotiLabel() {
    
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 20, width: screenW, height: screenH - 64))
        
        label.text = "这是一个控制器\nhttps://github.com/LMMIsGood/LiuqsChatSwift"
        
        label.font = UIFont.systemFont(ofSize: 40)
        
        label.numberOfLines = 0
        
        label.textColor = UIColor.white
        
        label.textAlignment = NSTextAlignment.center

        self.view.addSubview(label)
    }

    func initSomething() {
        
        self.view.backgroundColor = BLUE_Color
        
    }
    
    func creatEffectView() {
    
        let lightBlur = UIBlurEffect(style: UIBlurEffectStyle.light)
        
        let blurView = UIVisualEffectView(effect: lightBlur)
        
        blurView.frame = self.view.bounds
        
        self.view.addSubview(blurView)
        
    }
    
    func createCancelBtn() {
        
        let X:CGFloat = (screenW - 44) * 0.5
        
        let Y:CGFloat = screenH - 44
    
        let btn:UIButton = UIButton.init(frame: CGRect.init(x: X, y: Y, width: 44, height: 44))
        
        btn.backgroundColor = UIColor.clear
        
        CancelBtn = btn
        
        btn.layer.cornerRadius = 22;
        
        btn.addTarget(self, action: #selector(self.cancelBtnClick), for: UIControlEvents.touchUpInside)
        
        btn.setImage(UIImage.init(named: "tabbar_compose_icon_add"), for: UIControlState.normal)
        
        self.view.addSubview(btn)
        
    }
    
    func addtransAnimation() {
        
        UIView.animate(withDuration: 0.4) {
           
            self.CancelBtn.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2 * 0.5));
        }
    }
    
    func addFtransAnimation() {
     
        UIView.animate(withDuration: 0.4) {
            
            self.CancelBtn.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2 * 0.5));
        }

    }
    
    func cancelBtnClick(btn:UIButton) {
    
        self.dismiss(animated: true, completion: nil)
        
        addFtransAnimation()
        
    }
}
