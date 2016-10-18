//
//  tabBarController.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/8.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

protocol LiuqsTabBarDelegate {
    
    func composeBtnClicked()
}

class tabBarController: UITabBarController,UITabBarControllerDelegate, UIViewControllerTransitioningDelegate {
    
    var composeRect:CGRect = CGRect()
    
    var Delegate:LiuqsTabBarDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        self.transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChildViewControllers()
        
        addcomposedBtn()
        
        configureNav()
        
    }
    
  func configureNav() {
    
        self.navigationItem.title = "聊天"
    
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    /// 中间按钮的点击事件
    func clickcomposedBtn() {
        
        let addVC = AddViewController()
        
        addVC.transitioningDelegate = self
        
        self.present(addVC, animated: true, completion: {})
        
    }
    
    /// 添加中间按钮
    private func addcomposedBtn() {
        
        let composedBtnW = tabBar.bounds.width / CGFloat(viewControllers!.count)
        
        composedBtn.frame = CGRect(x:2 * composedBtnW, y: 0, width:composedBtnW , height: tabBar.bounds.height)
        
        composeRect = CGRect.init(x: composedBtn.frame.origin.x, y: composedBtn.frame.origin.y + screenH - 44, width: composedBtn.frame.size.height, height: composedBtn.frame.size.height)
        
        self.tabBar.addSubview(composedBtn)
    }
    
    /// 批量添加子控制器
    private func addChildViewControllers() {

        addChildViewController(ChatViewController(), title: "聊天", itemIcon: "tabbar_message_center")
        
        addChildViewController(HomeTableViewController(), title: "首页", itemIcon: "tabbar_home")
        
        addChildViewController(UIViewController(), title: "compose", itemIcon: "4")
        
        addChildViewController(DiscoverTableViewController(), title: "发现", itemIcon: "tabbar_discover")
        
        addChildViewController(PersonalViewController(), title: "我", itemIcon: "tabbar_profile")
    }
    
    
    
    /// 添加视图控制；
    private func addChildViewController(_ vc:UIViewController,title:String,itemIcon:String) {
        
        
        vc.title = title //== vc.navigationItem.title = title vc.tabBarItem.title = title
        
        vc.tabBarItem.image = UIImage(named: itemIcon)
        
        if title == "compose" {vc.tabBarItem.isEnabled = false; vc.title = ""}
        
        let dic = [NSForegroundColorAttributeName:UIColor.white]
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.navigationBar.barStyle = UIBarStyle.black
        
        nav.navigationBar.titleTextAttributes = dic
        
        addChildViewController(nav)
        
    }
    
    /// 懒加载中间按钮
    lazy private var composedBtn:UIButton = {
        
        let composedBtn = UIButton()
        
        composedBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), for: UIControlState())
        composedBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: UIControlState.highlighted)
        
        composedBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: UIControlState())
        composedBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: UIControlState.highlighted)

        composedBtn.addTarget(self, action: #selector(self.clickcomposedBtn), for: UIControlEvents.touchUpInside)
        
        return composedBtn
    }()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let pushTran:LiuqsPushTransition = LiuqsPushTransition()
        
        pushTran.btnRect = CGRect.init(x: (screenW - 44) * 0.5, y: screenH - 44, width: 44, height: 44)
        
        return pushTran
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let pushTran:LiuqsPopTransition = LiuqsPopTransition()
        
        pushTran.btnRect = CGRect.init(x: (screenW - 44) * 0.5, y: screenH - 44, width: 44, height: 44)
        
        return pushTran
        
    }
}
