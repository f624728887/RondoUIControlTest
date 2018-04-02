//
//  PushAnimationProtocol.swift
//  RondoTest
//
//  Created by Rondo_dada on 2018/2/28.
//  Copyright © 2018年 Rondo. All rights reserved.
//

import UIKit

class PushAnimationProtocol: NSObject , UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.containerView.backgroundColor = UIColor.lightText
        
        let fromVc = transitionContext.viewController(forKey: .from)!
        let toVc = transitionContext.viewController(forKey: .to)!
        
        let toFrame = transitionContext.finalFrame(for: toVc)
        let boundsFrame = UIScreen.main.bounds
        
        toVc.view.frame = toFrame.offsetBy(dx: boundsFrame.size.width, dy: 0)
        
        transitionContext.containerView.addSubview(toVc.view)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            fromVc.view.alpha = 0.8
            toVc.view.frame = toFrame
        }) { (finished) in
            transitionContext.completeTransition(true)
            fromVc.view.alpha = 1.0
        }
        
    }
    

}
