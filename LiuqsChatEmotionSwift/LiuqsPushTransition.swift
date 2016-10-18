//
//  LiuqsPushTransition.swift
//  LiuqsChatEmotionSwift
//
//  Created by 刘全水 on 16/8/14.
//  Copyright © 2016年 刘全水. All rights reserved.
//

import UIKit

class LiuqsPushTransition: NSObject,UIViewControllerAnimatedTransitioning,CAAnimationDelegate {
    
    var btnRect:CGRect = CGRect.init()
    
    var TransitionContext: UIViewControllerContextTransitioning?;

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {

        return 0.4;
    
    }

   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

    TransitionContext = transitionContext
    
    let fromVC:UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
    
    let toVC:UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
    
    let containerView:UIView = transitionContext.containerView
    
    containerView.addSubview(fromVC.view)
    
    containerView.addSubview(toVC.view)
    
    let button:UIButton = UIButton.init(frame: btnRect)
    
    let finalPath:UIBezierPath = UIBezierPath.init(ovalIn: btnRect)
    
    let finalPoint:CGPoint;
    
    //判断触发点在哪个象限
    if(btnRect.origin.x > (toVC.view.bounds.size.width / 2)){
        if (btnRect.origin.y < (toVC.view.bounds.size.height / 2)) {
            //第一象限
            finalPoint = CGPoint.init(x: button.center.x - 0, y: button.center.y - toVC.view.bounds.maxY + 30)
            
        }else{
            //第四象限
            finalPoint = CGPoint.init(x: button.center.x - 0, y: button.center.y - 0)
        }
    }else{
        if (btnRect.origin.y < (toVC.view.bounds.size.height / 2)) {
            //第二象限
            finalPoint = CGPoint.init(x: button.center.x - toVC.view.bounds.maxX, y: button.center.y - toVC.view.bounds.maxY+30)
        }else{
            //第三象限
            finalPoint = CGPoint.init(x: button.center.x - toVC.view.bounds.maxX, y: button.center.y - 0)
        }
    }
    
    let radius:CGFloat = sqrt(finalPoint.x * finalPoint.x + finalPoint.y * finalPoint.y)

    let startPath:UIBezierPath = UIBezierPath.init(ovalIn:btnRect.insetBy(dx: -radius, dy: -radius))
    
    let maskLayer:CAShapeLayer = CAShapeLayer()
    
    maskLayer.path = startPath.cgPath
    
    toVC.view.layer.mask = maskLayer;
    
    let pushAnimation:CABasicAnimation = CABasicAnimation.init(keyPath: "path")
    
    pushAnimation.fromValue = finalPath.cgPath
    
    pushAnimation.toValue = startPath.cgPath
    
    pushAnimation.duration = self.transitionDuration(using: transitionContext)
    
    pushAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
    
    pushAnimation.delegate = self
    
    maskLayer.add(pushAnimation, forKey: "animation")
    
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        TransitionContext?.completeTransition(!(TransitionContext?.transitionWasCancelled)!)
        TransitionContext?.viewController(forKey: UITransitionContextViewControllerKey.from)?.view.layer.mask = nil
        TransitionContext?.viewController(forKey: UITransitionContextViewControllerKey.to)?.view.layer.mask = nil;
    }

}
