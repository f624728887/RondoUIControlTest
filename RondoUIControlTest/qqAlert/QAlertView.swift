//
//  QAlertView.swift
//  RondoTest
//
//  Created by Rondo_dada on 2017/12/15.
//  Copyright © 2017年 Rondo. All rights reserved.
//

import UIKit

enum QAlertPushStatus{
    case statusPushing // 弹出和收回公用此状态
    case statusPushed
    case statusUnpush
}

enum QAlertStatus{
//    case QAlertStatusNormal
    case statusFalse
    case statusSuccess
}

class QAlertView: UIView{
    
    static let sharedInstance = QAlertView()
    
    private var tipLabel : UILabel?
    private var tipImage : UIImageView?
    private var pushStatus : QAlertPushStatus?
    private var timer : CGFloat?
    private let showTime : CGFloat = 3
    private let alertHeight = macroRondoNavbarH() + 15
    private let alertDefualeY = -(macroRondoNavbarH() + 15)
    private let alertPushY = CGFloat(-15)
    private var animation = true
    
    internal required init() {
        super.init(frame: CGRect.init(x: 0, y: alertDefualeY, width: macroScreenWidth, height: alertHeight))
        
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.addSubview(self)
        
        let button = UIControl.init(frame: self.bounds)
        button.addTarget(self, action: #selector(makeAlertPackUp), for: UIControlEvents.touchUpInside)
        self.addSubview(button)
        
        tipImage = UIImageView.init()
        self.addSubview(tipImage!)
        tipImage!.mas_makeConstraints({ (make) in
            make?.centerY.equalTo()(self)?.offset()((macroRondoStatubarH())/2.0 + 2.5)
            make?.left.equalTo()(self)?.offset()(10)
            make?.width.equalTo()(20)
            make?.height.equalTo()(20)
        })
        
        tipLabel = UILabel.init()
        tipLabel?.font = UIFont.systemFont(ofSize: 14)
        tipLabel?.numberOfLines = 0
        self.addSubview(tipLabel!)
        tipLabel!.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self)?.offset()((macroRondoStatubarH())/2.0 + 2.5)
            make?.left.equalTo()(tipImage?.mas_right)?.offset()(10)
            make?.right.equalTo()(self)?.offset()(-10)
            make?.bottom.equalTo()(self)?.offset()(-2)
        }
        
        let line = UIView.init()
        line.backgroundColor = UIColor.lightGray
        self.addSubview(line)
        line.mas_makeConstraints { (make) in
            make?.width.equalTo()(self)
            make?.bottom.equalTo()(self)?.offset()(0.5)
            make?.height.equalTo()(0.5)
        }
        
        Timer.scheduledTimer(timeInterval: 0.1, target:self,selector:#selector(makeTime), userInfo:nil,repeats:true)
        
        pushStatus = QAlertPushStatus.statusUnpush
        
        timer = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func alert(tip : String, status : QAlertStatus) {
        tipLabel?.text = tip
        if status == QAlertStatus.statusFalse {
            tipImage?.image = UIImage.init(named: "alertFa")
            self.backgroundColor = alertYellowColor()
        }
        else if status == QAlertStatus.statusSuccess {
            tipImage?.image = UIImage.init(named: "alertSu")
            self.backgroundColor = alertBlueColor()
        }
        pushAnimation()
    }
    
    private func pushAnimation() {
        if pushStatus == QAlertPushStatus.statusUnpush {
            alertPushingSet()
            pushAlert()
        }
        else {
            timer = 0
        }
    }
    
    private func pushAlert() {
        if animation {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                self.frame = CGRect.init(x: 0, y: self.alertPushY, width: macroScreenWidth, height: self.alertHeight)
            }, completion: { (finished) in
                self.pushStatus = QAlertPushStatus.statusPushed
            })
        }
        else {
            UIView.animate(withDuration: 0.26, animations: {
                self.frame = CGRect.init(x: 0, y: self.alertPushY, width: macroScreenWidth, height: self.alertHeight)
            }) { (finish) in
                self.pushStatus = QAlertPushStatus.statusPushed
            }
        }
    }
    
    private func packUpAnimation() {
        alertPushingSet()
        if animation {
            UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.frame = CGRect.init(x: 0, y: self.alertPushY + 5, width: macroScreenWidth, height: self.alertHeight)
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.frame = CGRect.init(x: 0, y: self.alertDefualeY, width: macroScreenWidth, height: self.alertHeight)
                }, completion: { (finished) in
                    self.pushStatus = QAlertPushStatus.statusUnpush
                })
            })
        }
        else {
            UIView.animate(withDuration: 0.26, animations: {
                self.frame = CGRect.init(x: 0, y: self.alertDefualeY, width: macroScreenWidth, height: self.alertHeight)
            }, completion: { (finish) in
                self.pushStatus = QAlertPushStatus.statusUnpush
            })
        }
    }
    
    
    
    @objc func makeTime() {
        if pushStatus == QAlertPushStatus.statusPushed {
            timer! += CGFloat(0.1)
        }
        if pushStatus == QAlertPushStatus.statusPushed && timer! >= showTime {
            timer = 0
            packUpAnimation()
        }
    }
    
    func alertPushingSet() {
        pushStatus = QAlertPushStatus.statusPushing
        self.timer = 0
    }
    
    private var touchY : CGFloat?
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let t:UITouch = touch as! UITouch
            print(t.location(in: self))
            if touchY == nil {
                touchY = t.location(in: self).y
            }
            else if t.location(in: self).y < touchY! {
                makeAlertPackUp()
            }
        }
    }
    
    @objc func makeAlertPackUp() {
        alertPushingSet()
        UIView.animate(withDuration: 0.15, animations: {
            self.frame = CGRect.init(x: 0, y: self.alertDefualeY, width: macroScreenWidth, height: self.alertHeight)
        }) { (finish) in
            self.pushStatus = QAlertPushStatus.statusUnpush
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
