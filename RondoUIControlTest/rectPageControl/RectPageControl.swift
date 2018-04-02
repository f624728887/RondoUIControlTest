//
//  RectPageControl.swift
//  RondoTest
//
//  Created by Rondo_dada on 2017/12/14.
//  Copyright © 2017年 Rondo. All rights reserved.
//

import UIKit

class RectPageControl: UIView {

    var unselectColor : UIColor = UIColor.lightGray
    var selectedColor : UIColor = UIColor.gray
    var pageSelected : Int?
    
    fileprivate let pointWidth : CGFloat = 6
    fileprivate let pointInter : CGFloat = 4
    fileprivate var controlWidth : CGFloat?
    fileprivate var controlCount : Int?
    fileprivate let pointSelectedWidth : CGFloat = 18
    fileprivate var poindArr : [UIView]?
    
    required init(count : Int, selected : Int, centerPoint : CGPoint) {
        controlWidth = (pointWidth + pointInter) * CGFloat(count - 1) + pointSelectedWidth
        super.init(frame: CGRect.init(x: 0, y: 0, width: controlWidth!, height: pointWidth))
        center = centerPoint
        backgroundColor = UIColor.clear
        pageSelected = selected
        controlCount = count
        
        makeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func makeView() {
        poindArr = [UIView]()
        for index in 0 ..< controlCount! {
            let temp = UIView.init()
            self.addSubview(temp)
            
            var width = pointWidth
            if index == pageSelected {
                temp.backgroundColor = selectedColor
                width = pointSelectedWidth
            }
            else {
                temp.backgroundColor = unselectColor
                width = pointWidth
            }
            
            if index == 0 {
                temp.mas_makeConstraints({ (make) in
                    make?.left.equalTo()(self.mas_left);
                    make?.top.equalTo()(self.mas_top);
                    make?.height.equalTo()(self.mas_height);
                    make?.width.equalTo()(width);
                })
            }
            else {
                let before = poindArr![index - 1]
                temp.mas_makeConstraints({ (make) in
                    make?.left.equalTo()(before.mas_right)?.offset()(pointInter);
                    make?.top.equalTo()(self.mas_top);
                    make?.height.equalTo()(self.mas_height);
                    make?.width.equalTo()(width);
                })
            }
            
            poindArr?.append(temp)
        }
    }
    
    public func selectedChange(selected : Int) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.26)
        let oldSelected = poindArr![pageSelected!]
        let newSelected = poindArr![selected]
        oldSelected.backgroundColor = unselectColor
        newSelected.backgroundColor = selectedColor
        
        oldSelected.mas_updateConstraints { (make) in
            make?.width.equalTo()(pointWidth)
        }
        newSelected.mas_updateConstraints { (make) in
            make?.width.equalTo()(pointSelectedWidth)
        }
        
        pageSelected = selected
        self.layoutIfNeeded()
        
        UIView.commitAnimations()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
