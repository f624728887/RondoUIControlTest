//
//  PopAnimationProtocol.swift
//  RondoTest
//
//  Created by Rondo_dada on 2018/2/28.
//  Copyright © 2018年 Rondo. All rights reserved.
//

import UIKit

class PopAnimationProtocol: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.containerView.backgroundColor = UIColor.lightText
        
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVc = transitionContext.viewController(forKey: .to)!
        let finalFrame = toVc.view.frame
        transitionContext.containerView.addSubview(toVc.view)
        
        UIGraphicsBeginImageContextWithOptions(toVc.view.bounds.size, true, UIScreen.main.scale)
        toVc.view.drawHierarchy(in: toVc.view.bounds, afterScreenUpdates: false)
        let shotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let iamgeView = UIImageView.init(frame: toVc.view.bounds)
        iamgeView.image = shotImage
        transitionContext.containerView.addSubview(iamgeView)
        
        toVc.view.frame = finalFrame.offsetBy(dx: -finalFrame.size.width, dy: 0)

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            fromVC.view.frame = finalFrame.offsetBy(dx: finalFrame.size.width, dy: 0)
            toVc.view.frame = finalFrame
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
    }
}
