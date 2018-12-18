//
//  ScrollViewController.swift
//  ninth-week
//
//  Created by student on 2018/12/13.
//  Copyright © 2018年 李潘. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController,UIScrollViewDelegate {

    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBOutlet weak var pinchView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //--------------------------scrollView-----------------------------------------
        //设置代理
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        //加载图片
        for i in 1...5{
            let imageView = UIImageView(image: UIImage(named: "\(i)"))
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: CGFloat(i-1)*scrollView.bounds.width, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: scrollView.bounds.width*5, height: scrollView.bounds.height)
        //按一页一页的方式滚动
        scrollView.isPagingEnabled = true
        //隐藏水平滚动条
        scrollView.showsHorizontalScrollIndicator = false
        //pagecontroll的数量
        pageControl.numberOfPages = 5
        //pagecontroll的初始位置
        pageControl.currentPage = 0;
        //指示器未选中时颜色
        pageControl.pageIndicatorTintColor = UIColor.red
        //指示器选中时颜色
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        //添加事件
        pageControl.addTarget(self, action: #selector(PageControlClicked(_:)), for: .touchUpInside)
        
        //--------------------------pinchView-----------------------------------------
        
        pinchView.backgroundColor = UIColor.black
        pinchView.contentSize = CGSize(width: pinchView.bounds.width, height: pinchView.bounds.height)
        //最大缩放比例
        pinchView.maximumZoomScale = 10
        //最小缩放比例
        pinchView.minimumZoomScale = 0.1
        //设置代理
        pinchView.delegate = self
        self.view.addSubview(pinchView)
        //加载图片
        let imageViewPinch = UIImageView(image: UIImage(named: "6"))
        imageViewPinch.frame = CGRect(x: 0, y: 0, width: pinchView.bounds.width, height: pinchView.bounds.height)
        imageViewPinch.contentMode = .scaleAspectFill
        pinchView.addSubview(imageViewPinch)
        
    }
    //实现pageControl跟随图片移动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x/(scrollView.bounds.width)
        pageControl.currentPage = Int(currentPage)
    }
    @IBAction func PageControlClicked(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        let rect = CGRect(x: CGFloat(currentPage) * scrollView.bounds.width, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
        scrollView.scrollRectToVisible(rect, animated: true)
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return pinchView.subviews.first
    }
    
    
    
    
    
}
