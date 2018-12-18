//
//  ViewController.swift
//  ninth-week
//
//  Created by student on 2018/12/13.
//  Copyright © 2018年 李潘. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
//--------------------------视图操作-----------------------------------------
    @IBAction func addView(_ sender: Any) {
        //随机产生坐标
        let viewX = Int(arc4random()) % Int(self.view.bounds.width)
        let viewY = Int(arc4random()) % Int(self.view.bounds.height)
        //图形
        let labelView = UILabel(frame: CGRect(x: viewX, y: viewY, width: 30, height: 30))
        labelView.text = "Hi!"
        //图形的文字中心对齐
        labelView.textAlignment = .center
        labelView.backgroundColor = UIColor.green
        //阴影设置
        labelView.layer.shadowColor = UIColor.black.cgColor
        labelView.layer.shadowOffset = CGSize(width: 10, height: 10)
        labelView.layer.shadowOpacity = 1
        //图形移动
        let  labelPanGesture = UIPanGestureRecognizer(target: self, action: #selector(lablePan(recognizer:)))
        labelView.addGestureRecognizer(labelPanGesture)

        //图形删除
        let  labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(lableTap(recognizer:)))
        labelView.addGestureRecognizer(labelTapGesture)
        labelTapGesture.numberOfTapsRequired = 2
        //图形旋转
        let  labelRotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(lableRotation(recognizer:)))
        labelView.addGestureRecognizer(labelRotationGesture)
        self.view.addSubview(labelView)
    }
    //move
    @objc func lablePan(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .changed  || recognizer.state == .ended {
            let translation = recognizer.translation(in: self.view)
            recognizer.view?.center.x += translation.x
            recognizer.view?.center.y += translation.y
            recognizer.setTranslation(.zero, in: self.view)
        }
    }
   
    //删除
    @objc func lableTap(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .recognized {
            recognizer.view?.removeFromSuperview()
        }
    }
    //旋转
    @objc func lableRotation(recognizer: UIRotationGestureRecognizer) {
        let rotation = recognizer.rotation
        recognizer.view?.transform = (recognizer.view?.transform.rotated(by: rotation))!
        recognizer.rotation = 0
    }
    
    
    
    
    

    //通过add添加的视图的移动
    @IBAction func moveView(_ sender: Any) {
        for labels in self.view.subviews {
            if labels is UILabel {
                UIView.animate(withDuration: 1) {
                    let x = Int(arc4random()) % Int(self.view.bounds.width)
                    let y = Int(arc4random()) % Int(self.view.bounds.height)
                    labels.center = CGPoint(x: x, y: y)
                }
            }
        }
        
    }
    
    
    //删除所有过add添加的视图
    @IBAction func deleteAllView(_ sender: Any) {
    
        for label in self.view.subviews {
            if label is UILabel {
                label.removeFromSuperview()
            }
        }
    }
//--------------------------UIAlertController-----------------------------------------
    
    @IBAction func actionSheet(_ sender: Any) {
        
        let alert = UIAlertController(title: "action sheet", message: "this is an action sheet", preferredStyle: .actionSheet)
        //改变背景颜色
        alert.addAction(UIAlertAction(title: "white", style: .default, handler: { (action) in
            self.view.backgroundColor = UIColor.white
        }))
        alert.addAction(UIAlertAction(title: "yellow", style: .default, handler: { (action) in
            self.view.backgroundColor = UIColor.yellow
        }))
        alert.addAction(UIAlertAction(title: "black", style: .default, handler: { (action) in
            self.view.backgroundColor = UIColor.black
        }))
        present(alert,animated: true,completion: nil)
    }
    
    
    @IBAction func Login(_ sender: Any) {
        
        let loginAlert = UIAlertController(title: "login", message: "input your information", preferredStyle: .alert)
        loginAlert.addAction(UIAlertAction(title: "login", style: .default, handler: { (Action) in
            if let userNameTextFiled = loginAlert.textFields?.first,let passWordTextFiled = loginAlert.textFields?.last{
                print("username:\(userNameTextFiled.text!) password:\(passWordTextFiled.text!)")
            }
            
        }))
        loginAlert.addAction(UIAlertAction(title: "cancle", style: .cancel, handler: { (ACTION) in
        }))
        //设置阴影提示
        loginAlert.addTextField{(textFiled) in
            textFiled.placeholder = "your user name?"
        }
        
        loginAlert.addTextField{(textFiled) in
            textFiled.placeholder = "your password?"
            //保密模式
            textFiled.isSecureTextEntry = true
        }
        present(loginAlert,animated: true,completion: nil)
    }
    
}
