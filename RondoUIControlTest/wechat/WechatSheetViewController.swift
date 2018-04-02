//
//  WechatSheetViewController.swift
//  RondoTest
//
//  Created by Rondo_dada on 2017/12/12.
//  Copyright © 2017年 Rondo. All rights reserved.
//

import UIKit

public protocol WechatSelectedDelegate : NSObjectProtocol {
    func wechatSelected(sheet : WechatSheetViewController, index : NSInteger) -> Void
}

open class WechatSheetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak open var delegate : WechatSelectedDelegate?
    
    fileprivate var myblock : selectedBlock?
    fileprivate let animationTime = 0.26
    fileprivate var transView : UIView?
    fileprivate var titleList : [String]?
    fileprivate var tableView : UITableView?
    fileprivate var tableHeight : Int?

    public typealias selectedBlock = (_ index : NSInteger) -> Void
    
    required public init?(buttonTitleList : [String]) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.clear
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalPresentationStyle = .custom
        
        titleList = buttonTitleList
        
//        cell height is 49    footerview height is 10
        tableHeight = (titleList!.count + 1) * 49 + 10 + Int(macroRondHomeBarH());
        
        makeView();
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: animationTime) {
            [weak self] in
            if let strongSelf = self {
                strongSelf.transView?.alpha = 0.5
                
                strongSelf.tableView?.frame = CGRect.init(x: 0, y: macroFullScreenHeight - CGFloat(strongSelf.tableHeight!), width: macroScreenWidth, height: CGFloat(strongSelf.tableHeight!))
            }
        }
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func makeView() {
        transView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: macroScreenWidth, height: macroFullScreenHeight))
        transView?.backgroundColor = UIColor.lightGray
        transView?.alpha = 0
        view.addSubview(transView!)
        
        let transButton : UIControl = UIControl.init(frame: view.bounds)
        transButton.backgroundColor = UIColor.clear
        transButton.addTarget(self, action: #selector(controlDismiss), for: .touchUpInside)
        view.addSubview(transButton)
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: macroFullScreenHeight, width: macroScreenWidth, height: CGFloat(tableHeight!)), style: UITableViewStyle.plain)
        tableView?.bounces = false
        tableView?.isScrollEnabled = false
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.clipsToBounds = true
        tableView?.backgroundColor = UIColor.white
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        view.addSubview(tableView!)
        
    }
    
//    mark   UITableView delegate and datasource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return titleList!.count
        }
        else {
           return 1
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            let footer = UIView.init(frame: CGRect.init(x: 0, y: 0, width: macroScreenWidth, height: 10))
            footer.backgroundColor = UIColor.lightGray
            return footer
        }
        else {
            return UIView.init()
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "cellid"
        
        var cell : WechatSheetTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? WechatSheetTableViewCell
        
        if cell == nil {
            cell = WechatSheetTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
        }
        
        if indexPath.section == 0 {
            cell?.setCell(title: titleList![indexPath.row])
        }
        else {
            cell?.setCell(title: "取消")
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        controlDismiss()
        
        if myblock != nil && indexPath.section == 0 {
            myblock!(indexPath.row)
        }
        
        if delegate != nil && indexPath.section == 0 {
            delegate?.wechatSelected(sheet: self, index: indexPath.row)
        }
    }
    
    @objc fileprivate func controlDismiss() {
        UIView.animate(withDuration: animationTime, animations: {
            [weak self] in
            if let strongSelf = self {
                strongSelf.transView?.alpha = 0
                
                strongSelf.tableView?.frame = CGRect.init(x: 0, y: macroFullScreenHeight, width: macroScreenWidth, height: CGFloat(strongSelf.tableHeight!))
            }
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    public func setSelectedBlock(block : selectedBlock?) -> Void {
        myblock = block
    }
    
    deinit {
        print("sheet deinit")
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
