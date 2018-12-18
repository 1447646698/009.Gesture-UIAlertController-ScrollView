//
//  lpUIView.swift
//  ninth-week
//
//  Created by student on 2018/12/13.
//  Copyright © 2018年 李潘. All rights reserved.
//

import UIKit

class lpView: UIView {
    
    @IBInspectable var color:UIColor?
    func setup(){
        //设置阴影
        self.layer.shadowColor = UIColor.yellow.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 1
        //move
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:)))
        self.addGestureRecognizer(panGesture )
        //缩放
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch(recognizer:)))
        self.addGestureRecognizer(pinchGesture)
        //删除
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(recognizer:)))
        self.addGestureRecognizer(tapGesture)
        //双击删除
        tapGesture.numberOfTapsRequired = 2
        //旋转
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotation(recognizer: )))
        self.addGestureRecognizer(rotationGesture)
        
        
    }
    //move
    @objc func pan(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .changed  || recognizer.state == .ended {
            let translation = recognizer.translation(in: self)
            self.center.x += translation.x
            self.center.y += translation.y
            recognizer.setTranslation(.zero, in: self)
        }
    }
    //缩放
    @objc func pinch(recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .changed  || recognizer.state == .ended {
            bounds = CGRect(x: 0, y: 0, width: bounds.width * recognizer.scale, height: bounds.height * recognizer.scale)
            
            recognizer.scale = 1
            
        }
    }
    //删除
    @objc func tap(recognizer: UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
    //旋转
    @objc func rotation(recognizer: UIRotationGestureRecognizer) {
        let rotation = recognizer.rotation
        self.transform = self.transform.rotated(by: rotation)
        recognizer.rotation = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        color?.setFill()
        path.fill()
    }
    
    
}
