//
//  RondoHorizontalTableView.swift
//  RondoTest
//
//  Created by Rondo_dada on 2017/12/29.
//  Copyright © 2017年 Rondo. All rights reserved.
//

import UIKit

@objc public protocol RondoHorizontalTableViewDelegate : NSObjectProtocol {
    func rondoTableView(numberOfCell tableView : RondoHorizontalTableView) -> Int
    func rondoTableView(tableViewCell tableView : RondoHorizontalTableView, index : Int) -> RondoTableViewCell
    
    /// default is 100
    @objc optional func rondoTableView(widthOfCell tableView : RondoHorizontalTableView, index : Int) -> CGFloat 
}

open class RondoHorizontalTableView: UIScrollView, UIScrollViewDelegate {
    
    weak open var tableViewDelegate: RondoHorizontalTableViewDelegate?
    
    private let dicCellIndex = "cellDicIndex"
    private let dicCellRect = "cellDicRect"
    
    private var tableViewWidth : CGFloat = 0
    private var cellCount : Int = 0
    private var frameArray = [[String : Any]]()
    private var cellWidth : CGFloat = 100
    private var visibleCells = [RondoTableViewCell]()
    private var oldOffsetX : CGFloat = 0
    private var firstCellIndex : Int?
    private var lastCellIndex : Int?
    private var reuseCellDic = [String : Set<RondoTableViewCell>]()
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        if newWindow != nil {
            dataInit()
        }
    }
    
    open override func layoutSubviews() {
        
    }
    
    private func dataInit() {
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        
        if tableViewDelegate != nil {
            cellCount = tableViewDelegate!.rondoTableView(numberOfCell: self)
            frameArray.removeAll()
            
            if (tableViewDelegate!.responds(to: #selector(tableViewDelegate!.rondoTableView(widthOfCell:index:)))) {
                for index : Int in 0 ..< cellCount {
                    let cellWidth = tableViewDelegate!.rondoTableView!(widthOfCell: self, index: index)
                    var beforeMaxX : CGFloat?
                    
                    if index == 0 {
                        beforeMaxX = 0;
                    }
                    else {
                        let cellrect = frameArray.last![dicCellRect] as! CGRect
                        
                        beforeMaxX = cellrect.maxX
                    }
                    
                    let cellRect = CGRect.init(x: beforeMaxX!, y: 0, width: cellWidth, height: self.frame.height)
                    
                    let cellDic = [dicCellIndex : index, dicCellRect : cellRect] as [String : Any]
                    
                    frameArray.append(cellDic)
                }
            }
            else {
                for index : Int in 0 ..< cellCount {
                    let cellRect = CGRect.init(x: (CGFloat(index) * cellWidth), y: 0, width: cellWidth, height: self.frame.height)
                    
                    let cellDic = [dicCellIndex : index, dicCellRect : cellRect] as [String : Any]
                    
                    frameArray.append(cellDic)
                }
            }
        }
        
        self.delegate = nil
        let cellrect = frameArray.last![dicCellRect] as! CGRect
        self.contentSize = CGSize.init(width: cellrect.maxX, height: self.frame.height)
        self.delegate = self
        
        makeCell()
    }
    
    private func makeCell() {
        if !visibleCells.isEmpty {
            for temp : UIView in visibleCells {
                temp.removeFromSuperview()
            }
            visibleCells.removeAll()
        }
        
        let offsetX = self.contentOffset.x
        oldOffsetX = self.contentOffset.x
        
        var tempArr = frameArray
        
        while tempArr.count != 1 {
            
            var midIndex : Int?
            if tempArr.count == 2 {
                midIndex = 0;
            }
            else {
                midIndex = Int(tempArr.count / 2);
            }
            
            let midDic = tempArr[midIndex!]
            let midFrame = midDic[dicCellRect] as! CGRect
            
            if offsetX < midFrame.minX {
                tempArr.removeSubrange((midIndex! + 1) ... (tempArr.count - 1))
            }
            else if offsetX >= midFrame.minX  && offsetX <= midFrame.maxX{
                tempArr.removeAll()
                tempArr.append(midDic)
            }
            else {
                tempArr.removeSubrange(0 ... midIndex!)
            }
        }
        
        let firstCellDic = tempArr.first
        
        for index in firstCellDic![dicCellIndex] as! Int ..< frameArray.count {
            let cellDic = frameArray[index]
            let rect = cellDic[dicCellRect] as! CGRect
            
            let cell = tableViewDelegate?.rondoTableView(tableViewCell: self, index: index)
            cell?.frame = rect
            self.addSubview(cell!)
            visibleCells.append(cell!)
            
            if index == (firstCellDic![dicCellIndex] as! Int) {
                firstCellIndex = index
            }
            
            if rect.minX <= (offsetX + self.frame.width) && rect.maxX >= (offsetX + self.frame.width) {
                lastCellIndex = index
                break
            }
        }
        
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newOffsetX = scrollView.contentOffset.x
        
        if oldOffsetX < newOffsetX {
            var firstCellFrame = visibleCells.first!.frame
            var lastCellFrame = visibleCells.last!.frame
            while (lastCellFrame.maxX <= newOffsetX + self.frame.width && lastCellFrame.maxX < self.contentSize.width) {
                lastCellIndex! += 1
                let cellDic = frameArray[lastCellIndex!]
                let rect = cellDic[dicCellRect] as! CGRect
                let cell = tableViewDelegate?.rondoTableView(tableViewCell: self, index: lastCellIndex!)
                cell?.frame = rect
                self.addSubview(cell!)
                visibleCells.append(cell!)
                lastCellFrame = rect
            }
            while (firstCellFrame.maxX < newOffsetX && firstCellFrame.maxX < self.contentSize.width - self.frame.width) {
                firstCellIndex! += 1
                visibleCells.first!.removeFromSuperview()
                reuseDicAppend(cell: visibleCells.first!)
                visibleCells.remove(at: 0)
                firstCellFrame = visibleCells.first!.frame
            }
        }
        else {
            var firstCellFrame = visibleCells.first!.frame
            var lastCellFrame = visibleCells.last!.frame
            while (firstCellFrame.minX >= newOffsetX && firstCellFrame.minX > 0) {
                firstCellIndex! -= 1
                let cellDic = frameArray[firstCellIndex!]
                let rect = cellDic[dicCellRect] as! CGRect
                let cell = tableViewDelegate?.rondoTableView(tableViewCell: self, index: firstCellIndex!)
                cell?.frame = rect
                self.addSubview(cell!)
                visibleCells.insert(cell!, at: 0)
                firstCellFrame = rect
            }
            while (lastCellFrame.minX > (newOffsetX + self.frame.width) && lastCellFrame.minX > self.frame.width) {
                lastCellIndex! -= 1
                visibleCells.last!.removeFromSuperview()
                reuseDicAppend(cell: visibleCells.last!)
                visibleCells.removeLast()
                lastCellFrame = visibleCells.last!.frame
            }
        }
        oldOffsetX = newOffsetX
    }
    
    private func reuseDicAppend(cell : RondoTableViewCell) {
        var temp = reuseCellDic[cell.reuseIdentifier!]
        if temp == nil {
            temp = [cell]
        }
        else {
            temp?.insert(cell)
        }
        reuseCellDic[cell.reuseIdentifier!] = temp
    }
    
    public func dequeueReusable(cellWithIdentifier identifier : String) -> RondoTableViewCell? {
        var temp = reuseCellDic[identifier]
        let cell = temp?.first
        
        if cell != nil {
            temp?.removeFirst()
            reuseCellDic[cell!.reuseIdentifier!] = temp
        }
        return cell
    }
    
    public func rondoTableViewReload() {
        dataInit()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
