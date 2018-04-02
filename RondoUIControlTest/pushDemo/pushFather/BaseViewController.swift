//
//  BaseViewController.swift
//  RondoTest
//
//  Created by Rondo_dada on 2018/2/28.
//  Copyright © 2018年 Rondo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    let pushAnimation = PushAnimationProtocol.init()
    let popAnimation = PopAnimationProtocol()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self;
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    //    navigationDelegate
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.push {
            return pushAnimation
        }
        else if operation == UINavigationControllerOperation.pop {
            return popAnimation
        }
        else {
            return nil
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
