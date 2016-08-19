//
//  BaseViewController.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/14.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,LiuqsTabBarDelegate,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

       self.navigationController?.navigationBar.barStyle = UIBarStyle.black 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        let tabbarController:tabBarController = self.tabBarController as! tabBarController
        
        self.navigationController?.delegate = self
        
        tabbarController.Delegate = self
    }
    
    func composeBtnClicked() {
        
        self.navigationController?.pushViewController(AddViewController(), animated: true)
        
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
    
        if operation == UINavigationControllerOperation.push && toVC.isKind(of: AddViewController().classForCoder) {
            
            let pushTran:LiuqsPushTransition = LiuqsPushTransition()
            
            let tabbarControl:tabBarController = self.tabBarController as! tabBarController
            
            pushTran.btnRect = tabbarControl.composeRect
            
            return pushTran
        }else {
        
            return nil
        }
    }

}
