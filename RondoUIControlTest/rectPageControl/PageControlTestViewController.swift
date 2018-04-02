//
//  PageControlTestViewController.swift
//  RondoTest
//
//  Created by Rondo_dada on 2017/12/14.
//  Copyright © 2017年 Rondo. All rights reserved.
//

import UIKit

class PageControlTestViewController: BaseViewController, UIScrollViewDelegate {

    fileprivate var scrollView : UIScrollView?
    fileprivate let scrollWidth : CGFloat = 300
    fileprivate let scrollHeight : CGFloat = 200
    fileprivate var pageControl : RectPageControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dateInit()
        makeView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dateInit() {
        view.backgroundColor = UIColor.white
        
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let backButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 40))
        backButton.setTitle("返回", for: UIControlState.normal)
        backButton.backgroundColor = UIColor.blue
        backButton.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
    }
    
    @objc func backClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func makeView() {
        let baseView = UIView.init(frame: CGRect.init(x: (macroScreenWidth - scrollWidth)/2, y: macroRondoNavbarH() + 20, width: scrollWidth, height: scrollHeight))
        view.addSubview(baseView)
        
        scrollView = UIScrollView.init(frame: baseView.bounds)
        scrollView?.backgroundColor = UIColor.blue
        scrollView?.contentSize = CGSize.init(width: scrollWidth * 5, height: scrollHeight)
        scrollView?.isPagingEnabled = true
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.delegate = self
        baseView.addSubview(scrollView!)
        
        for index in 0 ... 4 {
            let tempView = UIView.init(frame: CGRect.init(x: scrollWidth * CGFloat(index), y: 0, width: scrollWidth, height: scrollHeight))
            if index % 2 == 0 {
                tempView.backgroundColor = UIColor.yellow
            }
            else {
                tempView.backgroundColor = UIColor.red
            }
            scrollView?.addSubview(tempView)
        }
        
        pageControl = RectPageControl.init(count: 5, selected: 0, centerPoint: CGPoint.init(x: scrollWidth/2, y: scrollHeight - 20))
        baseView.addSubview(pageControl!)
        
    }
    
//    mark scrollView delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let page = lroundf(Float(scrollView.contentOffset.x/scrollWidth))
        if page != pageControl?.pageSelected {
            pageControl?.selectedChange(selected: page)
        }
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
