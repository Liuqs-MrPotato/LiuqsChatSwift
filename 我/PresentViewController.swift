//
//  PresentViewController.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/9/8.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class PresentViewController: UIViewController, UINavigationControllerDelegate{

    var CancelBtn:UIButton = UIButton.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSomething()
        createCancelBtn()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        addtransAnimation()
        
        self.navigationController?.delegate = self
        
        self.navigationController?.navigationBar.isHidden = true;
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.lightContent
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
        
        self.navigationController?.popViewController(animated: true)
        
        addFtransAnimation()
        
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let pushTran:LiuqsPopTransition = LiuqsPopTransition()
        
        pushTran.btnRect = CGRect.init(x: (screenW - 44) * 0.5, y: screenH - 44, width: 44, height: 44)
        
        return pushTran
    }

}
