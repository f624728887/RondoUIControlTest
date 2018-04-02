//
//  HorizontalViewController.swift
//  RondoTest
//
//  Created by Rondo_dada on 2017/12/29.
//  Copyright © 2017年 Rondo. All rights reserved.
//

import UIKit

class HorizontalViewController: BaseViewController, RondoHorizontalTableViewDelegate, UIScrollViewDelegate {

    private var cellNumber = 30
    private var tableView : RondoHorizontalTableView?
    
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
        tableView = RondoHorizontalTableView.init(frame: CGRect.init(x: 0, y: 100, width: macroScreenWidth, height: 200))
        tableView?.tableViewDelegate = self
        tableView?.delegate = self;
        view.addSubview(tableView!)
        
        
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 350, width: 100, height: 40))
        button.setTitle("+30", for: UIControlState.normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(buttonClick), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
        
        let button2 = UIButton.init(frame: CGRect.init(x: 200, y: 350, width: 100, height: 40))
        button2.setTitle("-30", for: UIControlState.normal)
        button2.backgroundColor = UIColor.blue
        button2.addTarget(self, action: #selector(button2Click), for: UIControlEvents.touchUpInside)
        view.addSubview(button2)
    }
    
    @objc func buttonClick() {
        cellNumber += 30
        tableView?.rondoTableViewReload()
    }
    
    @objc func button2Click() {
        if cellNumber > 30 {
            cellNumber -= 30
            tableView?.rondoTableViewReload()
        }
    }
    
//    rondoTableView delegate
    func rondoTableView(numberOfCell tableView: RondoHorizontalTableView) -> Int {
        return cellNumber
    }
    
    func rondoTableView(tableViewCell tableView: RondoHorizontalTableView, index: Int) -> RondoTableViewCell {
        
        let cellId = "cellid"
        
        var cell = tableView.dequeueReusable(cellWithIdentifier: cellId)
        if cell == nil {
            cell = RondoTableViewCell.init(reuseIdentifier: cellId)
        }
        
        for temp in cell!.subviews {
            temp.removeFromSuperview()
        }
        
        let indexLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 200))
        indexLabel.text = String(index)
        indexLabel.textColor = UIColor.black
        indexLabel.font = UIFont.systemFont(ofSize: 22)
        cell!.addSubview(indexLabel)
        
        return cell! 
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
