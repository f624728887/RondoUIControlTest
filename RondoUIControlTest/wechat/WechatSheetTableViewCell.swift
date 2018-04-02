//
//  WechatSheetTableViewCell.swift
//  RondoTest
//
//  Created by Rondo_dada on 2017/12/13.
//  Copyright © 2017年 Rondo. All rights reserved.
//

import UIKit

class WechatSheetTableViewCell: UITableViewCell {
    
    fileprivate var titleLabel : UILabel?
    fileprivate var cellEndLine : UIView?
    
    required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier!)
        titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: macroScreenWidth, height: 49))
        titleLabel?.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(titleLabel!)
        
        cellEndLine = UIView.init(frame: CGRect.init(x: 0, y: 49, width: macroScreenWidth, height: 0.5))
        cellEndLine?.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(cellEndLine!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setCell(title : String) {
        titleLabel?.text = title;
    }

}
