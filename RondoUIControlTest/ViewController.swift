//
//  ViewController.swift
//  RondoUIControlTest
//
//  Created by Rondo_dada on 2018/4/2.
//  Copyright © 2018年 Rondo. All rights reserved.
//

import UIKit

class ViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, WechatSelectedDelegate {

    var tableView : UITableView?
    var dataArr : [String]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initData()
        makeView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData() {
        view.backgroundColor = UIColor.white;
        navigationController?.title = "Test"
        dataArr = ["模仿微信选择框", "RectPageControl", "QQAlert", "横向tableview", "pushDemo", "模仿微信选择框", "RectPageControl", "模仿微信选择框", "RectPageControl", "模仿微信选择框", "RectPageControl", "模仿微信选择框", "RectPageControl", "模仿微信选择框", "RectPageControl", "模仿微信选择框", "RectPageControl", "模仿微信选择框", "RectPageControl", "模仿微信选择框", "RectPageControl", "模仿微信选择框", "RectPageControl", "模仿微信选择框", "RectPageControl", "模仿微信选择框", "RectPageControl"]
    }
    
    func makeView() {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: macroRondoNavbarH(), width: macroScreenWidth, height: macroFullScreenHeight - macroRondoNavbarH()), style: UITableViewStyle.plain)
        tableView?.delegate = self
        tableView?.backgroundColor = UIColor.white
        tableView?.dataSource = self
        tableView?.tableFooterView = UIView.init()
        tableView?.clipsToBounds = false
        view.addSubview(tableView!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr!.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId : String = "cellId"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = "\(dataArr![indexPath.row])"
        cell?.selectionStyle = UITableViewCellSelectionStyle.default
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch indexPath.row {
        case 0:
            let vc = WechatSheetViewController.init(buttonTitleList: ["从相册选择", "照相机", "大沙发斯蒂芬", "asdfasdfasdf"])
            vc?.delegate = self
            vc?.setSelectedBlock(block: { (index) in
                print("block选择了第\(index + 1)个选项")
            })
            print("初始化的\(String(describing: vc))")
            self.present(vc!, animated: false, completion: nil)
        case 1:
            let vc = PageControlTestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = QQAlertTestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = HorizontalViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = PushDemoViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            return
        }
    }
    
    //      WechatSheetViewController delegate
    func wechatSelected(sheet : WechatSheetViewController, index: NSInteger) {
        print("delegate中的\(String(describing: sheet))")
        print("delegae选择了第\(index + 1)个选项")
    }


}

