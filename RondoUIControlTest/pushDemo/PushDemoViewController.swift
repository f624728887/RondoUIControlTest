//
//  PushDemoViewController.swift
//  RondoTest
//
//  Created by Rondo_dada on 2018/2/28.
//  Copyright © 2018年 Rondo. All rights reserved.
//

import UIKit

class PushDemoViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        let pushButton = UIButton.init(frame: CGRect.init(x: 20, y: 100, width: 90, height: 30))
        pushButton.setTitle("pushNext", for: UIControlState.normal)
        pushButton.backgroundColor = UIColor.purple
        pushButton.addTarget(self, action: #selector(pushNextVc), for: UIControlEvents.touchUpInside)
        self.view.addSubview(pushButton)
    }

    @objc func pushNextVc() {
        let vc = PushFirstViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
