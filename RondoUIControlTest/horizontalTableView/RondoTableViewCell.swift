//
//  RondoTableViewCell.swift
//  RondoTest
//
//  Created by Rondo_dada on 2017/12/29.
//  Copyright © 2017年 Rondo. All rights reserved.
//

import UIKit

open class RondoTableViewCell: UIView {
    
    public var reuseIdentifier : String?
    
    required public init(reuseIdentifier : String) {
        super.init(frame: CGRect.init())
        self.backgroundColor = UIColor.red;
        self.reuseIdentifier = reuseIdentifier
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blue.cgColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
