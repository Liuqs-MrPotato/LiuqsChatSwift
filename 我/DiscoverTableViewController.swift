//
//  DiscoverTableViewController.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/8.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class DiscoverTableViewController: UIViewController, UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        initSomething()
    }
    
    func initSomething() {
        
        self.view.backgroundColor = UIColor.white;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let addVC = PresentViewController()
        
        self.tabBarController?.tabBar.isHidden = true
        
        self.navigationController?.pushViewController(addVC, animated: true)

    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == UINavigationControllerOperation.push {
           
            let pushTran:LiuqsPushTransition = LiuqsPushTransition()
            
            pushTran.btnRect = CGRect.init(x: (screenW - 44) * 0.5, y: screenH - 44, width: 44, height: 44)
            
            return pushTran
            
        }else {return nil}
        
    }
    
    
    
    
    

}
