//
//  QQAlertTestViewController.swift
//  RondoTest
//
//  Created by Rondo_dada on 2017/12/15.
//  Copyright © 2017年 Rondo. All rights reserved.
//

import UIKit

class QQAlertTestViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dataInit()
        makeView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataInit() {
        view.backgroundColor = UIColor.white
    }
    
    func makeView() {
        let button = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 40))
        button.setTitle("弹弹弹false", for: UIControlState.normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(alertPush), for: .touchUpInside);
        view.addSubview(button)
        
        let button2 = UIButton.init(frame: CGRect.init(x: 100, y: 200, width: 100, height: 40))
        button2.setTitle("弹弹弹success", for: UIControlState.normal)
        button2.backgroundColor = UIColor.blue
        button2.addTarget(self, action: #selector(alerthehe), for: .touchUpInside);
        view.addSubview(button2)
    }
    
    @objc func alertPush() {
        print("弹弹弹")
        
        let alert = QAlertView.sharedInstance
        alert.alert(tip: "这里是测试数据，测试行数阿卡丽火炬大厦法拉科技时代话费按累计收到回复卡号更多是否卡还是更多副科级安徽省搞的发卡机红烧冬瓜发", status: QAlertStatus.statusFalse)
    }
    
    @objc func alerthehe() {
        let alert = QAlertView.sharedInstance
        alert.alert(tip: "来看哈施蒂利克付建行奥斯卡到了房间号奥斯卡劳动纠纷阿斯利康京东方埃里克森交电话费阿拉山口交电话费昆仑决好", status: QAlertStatus.statusSuccess)
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
